package com.djamware.SecurityRest.controllers;

import com.djamware.SecurityRest.models.Agence;
import com.djamware.SecurityRest.repositories.AgenceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
public class AgenceController {

@Autowired
    AgenceRepository agenceRepository;


    @RequestMapping(method= RequestMethod.GET, value="/api/agences")
    public Iterable<Agence> agences() {
        return agenceRepository.findAll();
    }

    @RequestMapping(method=RequestMethod.POST, value="/api/agences")
    public String save(@RequestBody Agence agence) {
        agenceRepository.save(agence);

        return agence.getId();
    }

    @RequestMapping(method=RequestMethod.GET, value="/api/agences/{id}")
    public Optional<Agence> show(@PathVariable String id) {
        return agenceRepository.findById(id);
    }



    @RequestMapping(method=RequestMethod.PUT, value="/api/agences/{id}")
    public Agence update(@PathVariable String id, @RequestBody Agence agence) {
        Optional<Agence> agen = agenceRepository.findById(id);
        if(agence.getAgence() != null)
            agen.get().setAgence(agence.getAgence());

        agenceRepository.save(agen.get());
        return agen.get();
    }


    @RequestMapping(method=RequestMethod.DELETE, value="/api/agences/{id}")
    public String delete(@PathVariable String id) {
        Optional<Agence> agence = agenceRepository.findById(id);
        agenceRepository.delete(agence.get());

        return "agence deleted";
    }
}
