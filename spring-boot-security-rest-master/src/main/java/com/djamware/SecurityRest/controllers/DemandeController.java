package com.djamware.SecurityRest.controllers;

import com.djamware.SecurityRest.models.Demande;
import com.djamware.SecurityRest.repositories.DemandeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
public class DemandeController {

    @Autowired
    DemandeRepository demandeRepository;


    @RequestMapping(method= RequestMethod.GET, value="/api/demandes")
    public Iterable<Demande> demandes() {
        return demandeRepository.findAll();
    }





    @RequestMapping(method= RequestMethod.GET, value="/api/demande/{userid}")
    public Iterable<Demande> demandebyuserid(
            @PathVariable
            String userid) {
        return demandeRepository.findAllByUserid(userid);
    }


    @RequestMapping(method=RequestMethod.POST, value="/api/demandes")
    public String save(@RequestBody Demande demande) {
        demandeRepository.save(demande);

        return demande.getId();
    }

    @RequestMapping(method=RequestMethod.GET, value="/api/demandes/{id}")
    public Optional<Demande> show(@PathVariable String id) {
        return demandeRepository.findById(id);
    }



    @RequestMapping(method=RequestMethod.PUT, value="/api/demandes/{id}")
    public Demande update(@PathVariable String id, @RequestBody Demande demande) {
        Optional<Demande> dem = demandeRepository.findById(id);
        if(demande.getTypeDemande() != null)
            dem.get().setTypeDemande(demande.getTypeDemande());
        if(demande.getUserid() != null)
            dem.get().setUserid(demande.getUserid());
        if(demande.getStatus() != null)
            dem.get().setStatus(demande.getStatus());

        demandeRepository.save(dem.get());
        return dem.get();
    }


    @RequestMapping(method=RequestMethod.DELETE, value="/api/demandes/{id}")
    public String delete(@PathVariable String id) {
        Optional<Demande> demande = demandeRepository.findById(id);
        demandeRepository.delete(demande.get());

        return "demande deleted";
    }
}

