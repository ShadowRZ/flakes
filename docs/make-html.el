;; https://emacs.stackexchange.com/a/38515

;; Setup package.el
(require 'package)
(package-initialize)
(unless (package-installed-p 'htmlize)
  (package-install 'htmlize))
(unless (package-installed-p 'nix-mode)
  (package-install 'nix-mode))
(require 'font-lock)
(require 'org)
(require 'htmlize)
(require 'nix-mode)
(load-theme 'leuven t)
(setq org-src-fontify-natively t)

;; Override face-attribute
(require 'subr-x) ;; for `when-let'

(unless (boundp 'maximal-integer)
  (defconst maximal-integer (lsh -1 -1)
    "Maximal integer value representable natively in emacs lisp."))

(defun face-spec-default (spec)
  "Get list containing at most the default entry of face SPEC.
Return nil if SPEC has no default entry."
  (let* ((first (car-safe spec))
     (display (car-safe first)))
    (when (eq display 'default)
      (list (car-safe spec)))))

(defun face-spec-min-color (display-atts)
  "Get min-color entry of DISPLAY-ATTS pair from face spec."
  (let* ((display (car-safe display-atts)))
    (or (car-safe (cdr (assoc 'min-colors display)))
    maximal-integer)))

(defun face-spec-highest-color (spec)
  "Search face SPEC for highest color.
That means the DISPLAY entry of SPEC
with class 'color and highest min-color value."
  (let ((color-list (cl-remove-if-not
             (lambda (display-atts)
               (when-let ((display (car-safe display-atts))
                  (class (and (listp display)
                          (assoc 'class display)))
                  (background (assoc 'background display)))
             (and (member 'light (cdr background))
                  (member 'color (cdr class)))))
             spec)))
    (cl-reduce (lambda (display-atts1 display-atts2)
         (if (> (face-spec-min-color display-atts1)
            (face-spec-min-color display-atts2))
             display-atts1
           display-atts2))
           (cdr color-list)
           :initial-value (car color-list))))

(defun face-spec-t (spec)
  "Search face SPEC for fall back."
  (cl-find-if (lambda (display-atts)
        (eq (car-safe display-atts) t))
          spec))

(defun my-face-attribute (face attribute &optional frame inherit)
  "Get FACE ATTRIBUTE from `face-user-default-spec' and not from `face-attribute'."
  (let* ((face-spec (face-user-default-spec face))
     (display-attr (or (face-spec-highest-color face-spec)
               (face-spec-t face-spec)))
     (attr (cdr display-attr))
     (val (or (plist-get attr attribute) (car-safe (cdr (assoc attribute attr))))))
    (when (and (null (eq attribute :inherit))
           (null val))
      (let ((inherited-face (my-face-attribute face :inherit)))
    (when (and inherited-face
           (null (eq inherited-face 'unspecified)))
      (setq val (my-face-attribute inherited-face attribute)))))
    (or val 'unspecified)))

(advice-add 'face-attribute :override #'my-face-attribute)

(setq org-publish-project-alist
      '(("docs"
	 :base-directory "docs"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "docs/build/html")))
(org-publish-all)
