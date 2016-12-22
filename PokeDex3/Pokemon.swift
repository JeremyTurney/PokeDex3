//
//  Pokemon.swift
//  PokeDex3
//
//  Created by Jeremy Turney on 10/22/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon
{
    
    private var _name:String!
    private var _pokeDexID:Int!
    private var _description: String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    private var _pokemonURL:String!
    private var _nextEvolutionName:String!
    private var _nextEvolutionID:String!
    private var _nextEvolutionLevel:String!
    
    var name:String
    {
        return _name
    }
    
    var pokeDexID:Int
    {
        return _pokeDexID
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        
        return _description
    }
    
    var type: String
    {
        if _type == nil
        {
            _type = ""
        }
        
        return _type
    }
    
    var defense: String
    {
        if _defense == nil
        {
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String
    {
        if _height == nil
        {
            _height = ""
        }
        
        return _height
    }
    
    var weight: String
    {
        if _weight == nil
        {
            _weight = ""
        }
        
        return _weight
    }
    
    var attack: String
    {
        if _attack == nil
        {
            _attack = ""
        }
        
        return _attack
    }
    
    var nextEvolutionTxt: String
    {
        if _nextEvolutionTxt == nil
        {
            _nextEvolutionTxt = ""
        }
        
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String
    {
        if _nextEvolutionName == nil
        {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionID: String
    {
        if _nextEvolutionID == nil
        {
            _nextEvolutionID = ""
        }
        
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String
    {
        if _nextEvolutionLevel == nil
        {
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
    }
   
    
    init(name: String, pokeDexID: Int)
    {
        self._name = name
        self._pokeDexID = pokeDexID
        
        self._pokemonURL = "\(URL_Base)\(URL_Pokemon)\(self.pokeDexID)"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonURL).responseJSON
        { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = "\(weight)"
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = "\(height)"
                }
                
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defense = "\(defense)"
                }
                
                if let pokedexID = dict["pkdx_id"] as? Int
                {
                    self._pokeDexID = pokedexID
                }
                
               // print(self.pokeDexID)
                // print(self.height)
                // print(self.attack)
                print(self.defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0
                {
                    if let name = types[0]["name"]
                    {
                        self._type = name
                    }
                    
                    if types.count > 1
                    {
                        for x in 1..<types.count
                        {
                            if let name = types[x]["name"]
                            {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                }
                else
                {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0
                {
                    if let url = descArr[0]["resource_uri"]
                    {
                        Alamofire.request("http://pokeapi.co\(url)").responseJSON(completionHandler: { (response) in
                        
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>
                            {
                                if let descript = descDict["description"] as? String
                                {
                                    let newDescription = descript.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            completed()
                        })
                    }
                }
                else
                {
                    self._description = ""
                }
                
                if let evo = dict["evolutions"] as? [Dictionary<String, AnyObject>], evo.count > 0
                {
                    if let nextEvo = evo[0]["to"] as? String
                    {
                        if nextEvo.range(of: "mega") == nil
                        {
                            self._nextEvolutionName = nextEvo
                            
                            if let urls = evo[0]["resource_uri"]
                            {
                                let str = urls.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let newURLS = str.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = newURLS
                                
                                if let level = evo[0]["level"] as? Int
                                {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                else
                                {
                                    self._nextEvolutionLevel = ""
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    print(self.nextEvolutionID)
                    print(self.nextEvolutionName)
                    print(self.nextEvolutionLevel)
                }
            }
            completed()
        }
    }
    
}
