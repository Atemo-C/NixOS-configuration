# Which of the major GPU brands is used.
# This is used to guide which variant of packages should be installed.
# Can be one of `default` (intel & co), `amd`, or `nvidia-proprietary`.
{ ... }: { hardware. activeGpu = "default"; }