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
add '/Poi/locales/ca/LC_MESSAGES/*' '/src/Products.Poi/Products/Poi/locales/ca/LC_MESSAGES/'
add '/Poi/locales/es/LC_MESSAGES/*' '/src/Products.Poi/Products/Poi/locales/es/LC_MESSAGES/'

# WindowZ
# 2011-11-24 Ara esta al pypi upc
#add '/windowZ/locales/' '/src/Products.windowZ/Products/windowZ/'
# WindowZ no te locales al configure el sobreescribim
#add '/windowZ/configure.zcml' '/src/Products.windowZ/Products/windowZ/'


########
# EGGS
########

# PloneFormGen (desactivat) 
# a 1.7rc1, tenim les nostres traduccions!!!
#
# PloneFormGen no te traducció al català linkem tota la carpeta
#add '/PloneFormGen/locales/ca/' '/eggs/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/'
# plone form gen si té traducció al español
#add '/PloneFormGen/locales/es/LC_MESSAGES/*' '/eggs/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/es/LC_MESSAGES/'

#plone.app.locales
# Esborrat: al nou paquet està la traducció de la Lidia
# L'afegim ja que hi han cadenes que sobreeescribim
add '/plone.app.locales/ca/*' '/eggs/plone.app.locales*.egg/plone/app/locales/locales/ca/LC_MESSAGES/'
add '/plone.app.locales/es/*' '/eggs/plone.app.locales*.egg/plone/app/locales/locales/es/LC_MESSAGES/'

#plone.app.discussion
add '/plone.app.discussion/ca/*' '/eggs/plone.app.discussion*.egg/plone/app/discussion/locales/ca/LC_MESSAGES/'
add '/plone.app.discussion/es/*' '/eggs/plone.app.discussion*.egg/plone/app/discussion/locales/es/LC_MESSAGES/'

#Products.CMFCalendar
add '/CMFCalendar/ca' '/eggs/Products.CMFCalendar*.egg/Products/CMFCalendar/locales/'

i=0

for s in ${SOURCES[@]}; do
    
    #Expandim las rutes destí (aixi poden contenir *)
    for a in `echo $BUILD${DESTINATIONS[$i]}`; do
        echo 'Link to: '$a
        ln -s -f $TRANS$s $a
    done
    i=$(( $i + 1 ))

done



echo 'Links de les traduccions realitzades.'
