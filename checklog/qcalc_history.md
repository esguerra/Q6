# Qcalc version history

## Release 5.01
- Added feature to calculate solute entropies using Schlitter's formula
  and quasiharmonic analysis.
  
- Added feature to calculate nonboded interactions between defined atoms
  from a dcd or restart file.
  
- Added feature to calculate nonbonded interactions between a set of 
  residues, the protein, and atoms in a second set, e.g. q-atoms,
  from a dcd or restart file. Nonbonded interactions are calculated
  and averaged for one residue at the time to all q-atoms. 

## Release 4.25, 00-11-25
- Fixed problem with setting reference coordinates from a restart file.

## Release 4.21, 00-08-25
- Changed call to sign function to compile on SGI.

## Beta version 4.18, 00-07-14
- First 'public' version. This program replaces Qrms which could only 
  calculate RMS coordinate deviations (with no superimposition)

- Qcalc is a trajectory analysis program (but it can read restart
  files). It's designed to be used interactively, but input can
  be redirected from a file.

- Qcalc works in three stages:
1. Load topology.
2. Set up a list of calculations to make.
3. Read coordinates from trajectory and/or restart files and calculate.

- The following types of calculations are available:
1. RMS coord. deviation
2. Least squares fit
3. Distance, bond energy
4. Angle, angle energy
5. Torsion, torsion energy

- Multiple calculation of each kind can be done.
- For RMDs and fitting, an atom mask is used to select atoms.
