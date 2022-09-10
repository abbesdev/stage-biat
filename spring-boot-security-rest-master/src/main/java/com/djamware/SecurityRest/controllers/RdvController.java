package com.djamware.SecurityRest.controllers;

import com.djamware.SecurityRest.models.Demande;
import com.djamware.SecurityRest.models.Rdv;
import com.djamware.SecurityRest.repositories.DemandeRepository;
import com.djamware.SecurityRest.repositories.RdvRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
public class RdvController {

    @Autowired
    RdvRepository rdvRepository;


    @RequestMapping(method= RequestMethod.GET, value="/api/rdvs")
    public Iterable<Rdv> rdvs() {
        return rdvRepository.findAll();
    }

    @RequestMapping(method= RequestMethod.GET, value="/api/rdv/{clientId}")
    public Iterable<Rdv> rdvsbyclientid(
            @PathVariable
            String clientId) {
        return rdvRepository.findAllByClientId(clientId);
    }

    @RequestMapping(method= RequestMethod.GET, value="/api/rdvss/{chefId}")
    public Iterable<Rdv> rdvsbychefid(
            @PathVariable
            String chefId) {
        return rdvRepository.findAllByChefId(chefId);
    }
    @RequestMapping(method= RequestMethod.GET, value="/api/rdv/{clientId}/{startDate}")
    public Iterable<Rdv> rdvsbyclientidstart(
            @PathVariable
            String clientId, String startDate) {
        return rdvRepository.findAllByClientIdAndAndStartDate(clientId, startDate);
    }

    @RequestMapping(method=RequestMethod.POST, value="/api/rdvs")
    public String save(@RequestBody Rdv rdv) {
        rdvRepository.save(rdv);

        return rdv.getId();
    }

    @RequestMapping(method=RequestMethod.GET, value="/api/rdvs/{id}")
    public Optional<Rdv> show(@PathVariable String id) {
        return rdvRepository.findById(id);
    }



    @RequestMapping(method=RequestMethod.PUT, value="/api/rdvs/{id}")
    public Rdv update(@PathVariable String id, @RequestBody Rdv rdv) {
        Optional<Rdv> rdv1 = rdvRepository.findById(id);
        if(rdv.getTitle() != null)
            rdv1.get().setTitle(rdv.getTitle());
        if(rdv.getDescription() != null)
            rdv1.get().setDescription(rdv.getDescription());
        if(rdv.getStatus() != null)
            rdv1.get().setStatus(rdv.getStatus());
        if(rdv.getStartDate() != null)
            rdv1.get().setStartDate(rdv.getStartDate());
        if(rdv.getEndDate() != null)
            rdv1.get().setEndDate(rdv.getEndDate());
        if(rdv.getChefId() != null)
            rdv1.get().setChefId(rdv.getChefId());
        if(rdv.getClientId() != null)
            rdv1.get().setClientId(rdv.getClientId());

        rdvRepository.save(rdv1.get());
        return rdv1.get();
    }


    @RequestMapping(method=RequestMethod.DELETE, value="/api/rdvs/{id}")
    public String delete(@PathVariable String id) {
        Optional<Rdv> rdv = rdvRepository.findById(id);
        rdvRepository.delete(rdv.get());

        return "rdv deleted";
    }
}


