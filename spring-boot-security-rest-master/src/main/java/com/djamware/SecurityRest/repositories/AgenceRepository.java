package com.djamware.SecurityRest.repositories;

import com.djamware.SecurityRest.models.Agence;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface AgenceRepository extends CrudRepository<Agence, String> {

Optional<Agence> findById(String id);

}
