//
//  PokemonDetailVC.swift
//  PokeDex3
//
//  Created by Jeremy Turney on 10/24/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokeDexID)")
        mainImg.image = img

        
        currentEvoImg.image = img
        pokedexIDLbl.text = "\(pokemon.pokeDexID)"
        

        pokemon.downloadPokemonDetails
        {
            print("did arrive here")
             self.updateUI()
        }
    }

    @IBAction func backBtnPressed(_ sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
  
    func updateUI()
    {
        typeLbl.text = pokemon.type.capitalized
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        descriptionLbl.text = pokemon.description
        
        
        if pokemon.nextEvolutionID == ""
        {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        }
        else
        {
            let str = "Next Evolution: \(pokemon.nextEvolutionName) --LVL \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
            nextEvoImg.isHidden = false
            let evoImg = UIImage(named: "\(pokemon.nextEvolutionID)")
            nextEvoImg.image = evoImg

            
        }
        
        
    }
  
}
