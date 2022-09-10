package com.djamware.SecurityRest.repositories;

import com.djamware.SecurityRest.models.Demande;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface DemandeRepository extends CrudRepository<Demande, String> {
Optional<Demande> findById(String id);

Iterable<Demande> findAllByUserid(String userid);
}
