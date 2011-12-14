README.txt for Moodle Launcher module

Author: Menno de Ridder (m.ridder@solin.nl)

This Launcher module allows users to quickly install an entirely new
moodle environment with as few actions as possible.



1. Installation

Copy the modules 'launcher' and 'soda' to your moodle mod directory. Go to
the admininstrator section of your moodle installation and it will install
automatically.


2. Configuration



3. ASSUMPTIONS / PREREQUISITES

The moodle files are in /moodle_name/public_html/




4. CSV Fields description and prerequisites

Users

    * firstname -> De voornaam van de gebruiker
    * lastname -> De achternaam van de gebruiker
    * email -> Het email adres van de gebruiker
    * city -> De woonplaats van de gebruiker
    * country -> Het land van de gebruiker
    * rol1 -> De eerste rol van de gebruiker.
    * rol2 -> De tweede rol van de gebruiker. Omdat iemand in onze ogen zowel ICTer als docent kan zijn hebben we een tweede rol veld toegevoegd.
    * group1 -> De eerste groep waar de gebruiker in zit.
    * group2 -> De tweede groep waar de gebruiker in zit. Omdat een docent meerdere klassen tegelijk les kan geven hebben we in totaal 3 mogelijke groepen. Als dit er meer moeten zijn svp even feedback hierop.
    * group3 -> Een derde mogelijke groep waar een gebruiker in zit

Groups

    * name -> De naam van de groep.
    * year -> Het leerjaar van de groep.


Assumptions and prerequisites

Om het systeem foutloos te laten werken zullen de bestanden aan een aantal conventies moeten voldoen. Die zijn hier onder omschreven.

    * De volgende velden zijn altijd verplicht:
          o firstname
          o lastname
          o email
          o rol1
    * Wanneer een veld niet gevuld dient te worden (bijvoorbeeld wanneer iemand geen tweede rol heeft, of geen tweede groep), blijft dit veld leeg.
    * Een student heeft altijd maar 1 rol, en 1 groep.
    * Als iemand alleen ICTer is heeft die gebruiker geen groepen.
    * Een docent kan maximaal 3 groepen les geven.
    * De rollen en groepen moeten foutloos gespeld worden om de koppeling mogelijk te maken.
    * De verschillende mogelijke rollen zijn:
          o student -> Leerling
          o teacher -> Leraar
          o ict -> ICTer
