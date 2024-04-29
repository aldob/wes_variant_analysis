Whole-exome sequencing pipeline variant analysis pipeline.

The pipeline wwas designed to run with the Slurm manager and therefore each step is split into a separate file to more efficiently manage the resources.

The wes_slurm_pipe.sh is the master pipeline that initiates the other sub-process scripts for each step of the analysis.

