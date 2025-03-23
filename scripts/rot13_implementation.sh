#!/bin/bash
#=======================================================================================
# Author: Solorzano, Juan Jose.
# Date: 2020-07-07
# Version: 1.0
#---------------------------------------------------------------------------------------
# This script is used to implement the rot13 algorithm.
#=======================================================================================

data="Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi"
string="abcdefghijkl"
echo "roted string: Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi"
echo "Rotting 13 position means, count 'abcdefghijkln-m'"
echo "The lenght of the string is $(echo $string | wc -c) until the 'n' character"
echo "It means, to rotate a string you have to change from 'n' to 'z', and from 'm' to 'a'"
echo "Using tr we can group using: '[A-Za-a]'(all letters) to rotate '[N-ZA-Mn-za-m]'"
echo "Example: string=Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi"
echo ">> string | tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
echo "output:"
echo "$data" | tr '[A-Za-z]' '[N-ZA-Mn-za-m]'
