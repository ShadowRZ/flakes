#include <sys/prctl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  if (argc == 1) {
    fprintf(
      stderr,
      "Subreap Helper\nUsage: %s COMMAND [ARGUMENTS]...",
      argv[0]
    );
    return 1;
  }

  int prctl_result = prctl(PR_SET_CHILD_SUBREAPER, 1);
  if (prctl_result < 0) {
    fprintf(
      stderr,
      "ERROR: Subreap failed: %s, failback to normal wrapping.",
      strerror(prctl_result)
    );
  }
  
  const char *program = argv[1];
  int execvp_result = execvp(program, &argv[1]);
  perror("Executing program failed");

  return 1;
}
