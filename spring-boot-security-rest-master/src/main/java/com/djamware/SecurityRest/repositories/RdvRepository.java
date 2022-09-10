package com.djamware.SecurityRest.repositories;


import com.djamware.SecurityRest.models.Rdv;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface RdvRepository extends CrudRepository<Rdv, String> {
    Optional<Rdv> findById(String id);

    Iterable<Rdv> findAllByClientIdAndAndStartDate(String clientId, String startDate);

    Iterable<Rdv> findAllByChefId(String chefId);


    Iterable<Rdv> findAllByClientId(String clientId);
}
