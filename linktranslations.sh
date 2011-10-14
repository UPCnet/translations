#!/bin/bash
#Directori on estan les traduccions
TRANS=`pwd`
# BUILD tindria que ser el directori on esta el gw4, el valor seguent es la ruta relativa sense barra al final
BUILD=${TRANS//\/src\/translations/}

SOURCES=( )

DESTINATIONS=( )

function add {
    SOURCES[${#SOURCES[*]}]="$1"
    DESTINATIONS[${#DESTINATIONS[*]}]="$2"
}

############
# SRC LINKS
############

# Collage
# Collage ja té locales només actualitzar traduccions
add '/Collage/locales/es/LC_MESSAGES/*' '/src/Products.Collage/Products/Collage/locales/es/LC_MESSAGES/'
add '/Collage/locales/ca/LC_MESSAGES/*' '/src/Products.Collage/Products/Collage/locales/ca/LC_MESSAGES/'

#Ploneboard
add '/PloneBoard/configure.zcml' '/src/Products.Ploneboard/Products/Ploneboard/'
add '/PloneBoard/locales/' '/src/Products.Ploneboard/Products/Ploneboard/'

#PlonePopoll
add '/PlonePopoll/configure.zcml' '/src/Products.PlonePopoll/Products/PlonePopoll/'
add '/PlonePopoll/locales/' '/src/Products.PlonePopoll/Products/PlonePopoll/'

#PloneSurvey
add '/PloneSurvey/configure.zcml' '/src/Products.PloneSurvey/Products/PloneSurvey/'
add '/PloneSurvey/locales/' '/src/Products.PloneSurvey/Products/PloneSurvey/'

# Poi
# Poi ja té locales només actualitzar traduccions
add '/Poi/locales/ca/LC_MESSAGES/*' '/src/Products.Poi/Products/Poi/locales/ca/'
add '/Poi/locales/es/LC_MESSAGES/*' '/src/Products.Poi/Products/Poi/locales/es/'

# WindowZ
add '/windowZ/locales/' '/src/Products.windowZ/Products/windowZ/'
# WindowZ no te locales al configure el sobreescribim
add '/windowZ/configure.zcml' '/src/Products.windowZ/Products/windowZ/'


########
# EGGS
########

# PloneFormGen
# PloneFormGen no te traducció al català linkem tota la carpeta
# TODO comprovar que compila la traducció!
add '/PloneFormGen/locales/ca/' '/eggs/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/'
# plone form gen si té traducció al español
add '/PloneFormGen/locales/es/LC_MESSAGES/*' '/eggs/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/es/LC_MESSAGES/'




i=0

for s in ${SOURCES[@]}; do
    
    #echo $TRANS$s $BUILD${DESTINATIONS[$i]}
    ln -s -f $TRANS$s $BUILD${DESTINATIONS[$i]}
    i=$(( $i + 1 ))

done



echo 'Links de les traduccions realitzades.'
