#!/bin/bash
############################################################
# - linktranslations -
# Sobreescriu traduccions per defecte per propies
# Usage: linktranslations [-d]
# Parametres
#       -d      Mode desenvolupador (sobreescriure paquets src)
###############################################################
DEVELOP=false

# Llegim parametres
if [ "$1" = "-d" ]; then
  DEVELOP=true
fi

#Directori on estan les traduccions
TRANS=`pwd`

# BUILD tindria que ser el directori on esta el gw4, el valor seguent es la ruta relativa sense barra al final
# La ruta es diferent a desenvolupament que ha producció

BUILD=${TRANS//\/translations/}

if $DEVELOP ; then
    BUILD=${TRANS//\/src\/translations/}
fi

SOURCES=( )

DESTINATIONS=( )

# add(override, desti, develop)
# @override string ruta a la nostra traducció dins de TRANS
# @desti string ruta on va la traducció
# @develop true | false Indica si estem a mode develop si s'ha de buscar el
#                       paquet a egss o a src
function add {
    SOURCES[${#SOURCES[*]}]="$1"
    if $DEVELOP ; then        
        DESTINATIONS[${#DESTINATIONS[*]}]="/src$2"
    else
        DESTINATIONS[${#DESTINATIONS[*]}]="/eggs$2"
    fi
}

############
# SRC LINKS
############
DEVELOP=$DEVELOP
# Collage
# Collage ja té locales només actualitzar traduccions
add '/Collage/locales/es/LC_MESSAGES/*' '/Products.Collage*/Products/Collage/locales/es/LC_MESSAGES/'
add '/Collage/locales/ca/LC_MESSAGES/*' '/Products.Collage*/Products/Collage/locales/ca/LC_MESSAGES/'

#PlonePopoll
add '/PlonePopoll/configure.zcml' '/Products.PlonePopoll*/Products/PlonePopoll/' 
add '/PlonePopoll/locales/' '/Products.PlonePopoll*/Products/PlonePopoll/'

#PloneSurvey
add '/PloneSurvey/configure.zcml' '/Products.PloneSurvey*/Products/PloneSurvey/' $DEVELOP
add '/PloneSurvey/locales/' '/Products.PloneSurvey*/Products/PloneSurvey/'

# Poi
# Poi ja té locales només actualitzar traduccions
add '/Poi/locales/ca/LC_MESSAGES/*' '/Products.Poi*/Products/Poi/locales/ca/LC_MESSAGES/'
add '/Poi/locales/es/LC_MESSAGES/*' '/Products.Poi*/Products/Poi/locales/es/LC_MESSAGES/'

# WindowZ
# 2011-11-24 Ara esta al pypi upc
#add '/windowZ/locales/' '/Products.windowZ/Products/windowZ/'
# WindowZ no te locales al configure el sobreescribim
#add '/windowZ/configure.zcml' '/Products.windowZ/Products/windowZ/'


########
# EGGS
########
DEVELOP=false
# PloneFormGen (desactivat) 
# a 1.7rc1, tenim les nostres traduccions!!!
#
# PloneFormGen no te traducció al català linkem tota la carpeta
#add '/PloneFormGen/locales/ca/' '/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/'
# plone form gen si té traducció al español
#add '/PloneFormGen/locales/es/LC_MESSAGES/*' '/Products.PloneFormGen*.egg/Products/PloneFormGen/locales/es/LC_MESSAGES/'

#Ploneboard
add '/PloneBoard/configure.zcml' '/Products.Ploneboard*/Products/Ploneboard/'
add '/PloneBoard/locales/' '/Products.Ploneboard*/Products/Ploneboard/'

#plone.app.locales
# L'afegim ja que hi han cadenes que sobreeescribim
add '/plone.app.locales/ca/*' '/plone.app.locales*.egg/plone/app/locales/locales/ca/LC_MESSAGES/'
add '/plone.app.locales/es/*' '/plone.app.locales*.egg/plone/app/locales/locales/es/LC_MESSAGES/'

#plone.app.discussion
add '/plone.app.discussion/ca/*' '/plone.app.discussion*.egg/plone/app/discussion/locales/ca/LC_MESSAGES/'
add '/plone.app.discussion/es/*' '/plone.app.discussion*.egg/plone/app/discussion/locales/es/LC_MESSAGES/'

#Products.CMFCalendar
add '/CMFCalendar/ca' '/Products.CMFCalendar*.egg/Products/CMFCalendar/locales/'

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
