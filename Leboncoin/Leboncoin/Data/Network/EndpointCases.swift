//
//  NetworkApi.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

enum EndpointCases {
    case classifiedAds
    case categories
    case image(urlString: String)
}

extension EndpointCases: Endpoint {
    
    var baseURL: URL {
        switch self {
        case .image(let urlString):
            return URL(string: urlString)!
        default:
            return URL(string: Environment.serverUrl.value)!
        }
    }
    
    var path: String {
        switch self {
        case .classifiedAds:
            return "listing.json"
        case .categories:
            return "categories.json"
        case .image:
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        switch self {
        case .image:
            return nil
        default:
            return ["Accept": "application/json"]
        }
        
    }
    
    var query: [String : String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .categories:
            return """
                [{ "id": 1,"name": "Véhicule"},
                {"id": 2, "name": "Mode" },
                { "id": 3,"name": "Bricolage"}]
            """.data(using: .utf8)!
        case .classifiedAds:
            return """
                [
                   {
                      "id":1461267313,
                      "category_id":4,
                      "title":"Statue homme noir assis en plâtre polychrome",
                      "description":"Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
                      "price":140.00,
                      "images_url":{
                         "small":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                         "thumb":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"
                      },
                      "creation_date":"2019-11-05T15:56:59+0000",
                      "is_urgent":false
                   },
                   {
                      "id":1691247255,
                      "category_id":8,
                      "title":"Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd",
                      "description":"= = = = = = = = = PC PORTABLE HP ELITEBOOK 820 G1 = = = = = = = = = # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # HP ELITEBOOK 820 G1 Processeur : Intel Core i5 4300M Fréquence : 2,60 GHz Mémoire : 4 GO DDR3 Disque Dur : 320 GO SATA Vidéo : Intel HD Graphics Lecteur Optique : Lecteur/Graveur CD/DVDRW Réseau : LAN 10/100 Système : Windows 7 Pro – 64bits Etat : Reconditionné  Garantie : 6 Mois Prix TTC : 199,00 € Boostez ce PC PORTABLE : Passez à la vitesse supérieure en augmentant la RAM : Passez de 4 à 6 GO de RAM pour 19€  Passez de 4 à 8 GO de RAM pour 29€  (ajout rapide, doublez la vitesse en 5 min sur place !!!) Stockez plus en augmentant la capacité de votre disque dur : Passez en 500 GO HDD pour 29€  Passez en 1000 GO HDD pour 49€  Passez en 2000 GO HDD pour 89€  Passez en SSD pour un PC 10 Fois plus rapide : Passez en 120 GO SSD pour 49€  Passez en 240 GO SSD pour 79€  Passez en 480 GO SSD pour 119€ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # Nous avons plus de 300 Ordinateurs PC Portables. Visible en boutique avec une garantie de 6 mois vendu avec Facture TVA, pas de surprise !!!! Les prix varient en moyenne entre 150€ à 600€, PC Portables en stock dans notre boutique sur Paris. # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # KIATOO est une société qui regroupe à la fois: - PC Portable - PC de Bureau / Fixe - Chargeur PC Portable - Batterie PC Portable - Clavier PC Portable - Ventilateur PC Portable - Nappe LCD écran - Ecran LCD PC Portable - Mémoire PC Portable - Disque dur PC Portable - Inverter PC Portable - Connecteur Jack DC PC Portable ASUS, ACER, COMPAQ, DELL, EMACHINES, HP, IBM, LENOVO, MSI, PACKARD BELL, PANASONIC, SAMSUNG, SONY, TOSHIBA...",
                      "price":199.00,
                      "images_url":{
                         "small":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/633f278423b9aa6b04fa9cc954079befd294473f.jpg",
                         "thumb":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/633f278423b9aa6b04fa9cc954079befd294473f.jpg"
                      },
                      "creation_date":"2019-10-16T17:10:20+0000",
                      "is_urgent":false
                   }
                ]
                """.data(using: .utf8)!
        
        case .image:
            return Data()
        }
    }
}
