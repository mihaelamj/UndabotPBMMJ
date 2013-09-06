//
//  UPBMMJAppDelegate.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/3/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//




//zadatak glasi:
//Potrebno je napraviti aplikaciju koja dohvaća najpopularnije slike s Instagrama i prikazuje ih u listi. Uz sliku potrebno je prikazati njen naslov i ime autora.
//
//Ovaj zadatak dolazi u tri verzije. U prvoj verziji potrebno je dohvaćati slike s Flickra, dok se u drugoj verziji dohvaćaju najpopularnije slike s Instagrama. Treća verzija zadatka zahtjeva da se iz prve dvije verzije stvori novi treći projekt koji koristi i Instagram i Flickr kao izvor podataka. Tvoj zadatak je ponuditi rješenje koje će:
//što više olakšati rješavanje zadatka osobi koja dobije treću verziju
//sadržavati modularnu arhitekturu sustava, tj što jednostavniju integraciju dodatnog (drugog) izvora podataka.
//osigurati najbrže moguće predstavljanje podataka korisniku (osigurati minimalno vrijeme od trenutka pokretanja do trenutka prezentacije podataka)
//
//Dodatne informacije:
//Objekt slike u obje verzije zadatka sadrži iste atribute (naslov / autor)
//Ne postoje zahtjevi za dizajnom aplikacije
//Za sve nedoumice slobodno se javi.

#import <UIKit/UIKit.h>

@interface UPBMMJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
