package com.djamware.SecurityRest.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.djamware.SecurityRest.models.User;

import java.util.Optional;

public interface UserRepository extends MongoRepository<User, String> {


	User findByEmail(String email);
	Optional<User> findById(String id);
	Iterable<User> findAllByUserType(String userType);
	Iterable<User> findAllByStatus(String status);

	Iterable<User> findAllByIdAgenceAndUserType(String idAgence, String userType);
	default User getUserById(){

		return getUserById();
	}
}
