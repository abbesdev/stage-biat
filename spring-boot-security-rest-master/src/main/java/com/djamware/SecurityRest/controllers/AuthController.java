package com.djamware.SecurityRest.controllers;

import static org.springframework.http.ResponseEntity.ok;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import com.djamware.SecurityRest.models.Agence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.*;

import com.djamware.SecurityRest.configs.JwtTokenProvider;
import com.djamware.SecurityRest.models.User;
import com.djamware.SecurityRest.repositories.UserRepository;
import com.djamware.SecurityRest.services.CustomUserDetailsService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

	@Autowired
	AuthenticationManager authenticationManager;

	@Autowired
	JwtTokenProvider jwtTokenProvider;

	@Autowired
	UserRepository users;

	@Autowired
	private CustomUserDetailsService userService;

	@SuppressWarnings("rawtypes")
	@PostMapping("/login")
	public ResponseEntity login(@RequestBody AuthBody data) {
		try {
			String username = data.getEmail();
			String useruid = data.getId();
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, data.getPassword()));
			String token = jwtTokenProvider.createToken(username, this.users.findByEmail(username).getRoles());
			Map<Object, Object> model = new HashMap<>();
model.put("userid", this.users.findByEmail(username).getId());
model.put("cin", this.users.findByEmail(username).getCin());
model.put("userType", this.users.findByEmail(username).getUserType());
			model.put("status", this.users.findByEmail(username).getStatus());
			model.put("idAgence", this.users.findByEmail(username).getIdAgence());
			model.put("username", username);
			model.put("token", token);
			return ok(model);
		} catch (AuthenticationException e) {
			throw new BadCredentialsException("Invalid email/password supplied");
		}
	}

	@SuppressWarnings("rawtypes")
	@PostMapping("/register")
	public ResponseEntity register(@RequestBody User user) {

		User userExists = userService.findUserByEmail(user.getEmail());


		if (userExists != null) {
			throw new BadCredentialsException("User with username: " + user.getEmail() + " already exists");
		} else {
			userService.saveUser(user);
			Map<Object, Object> model = new HashMap<>();
			model.put("message", "User registered successfully");
			return ok(model);


		}
	}

	@RequestMapping(method= RequestMethod.PUT, value="/user/{id}")
	public User update(@PathVariable String id, @RequestBody User userss) {
		Optional<User> user = users.findById(id);
		if(userss.getFullname() != null)
			user.get().setFullname(userss.getFullname());
		if(userss.getCin() != null)
			user.get().setCin(userss.getCin());
		if(userss.getIdAgence() != null)
			user.get().setIdAgence(userss.getIdAgence());
		if(userss.getUserType() != null)
			user.get().setUserType(userss.getUserType());
		if(userss.getStatus() !=null)
			user.get().setStatus(userss.getStatus());

		if (userss.getScore() !=null)
			user.get().setScore(userss.getScore());


		users.save(user.get());
		return user.get();
	}



	@RequestMapping(method=RequestMethod.GET, value="/users/{userType}")
	public Iterable<User> showusers(@PathVariable String userType) {
		return (Iterable<User>) users.findAllByUserType(userType);
	}
	@RequestMapping(method=RequestMethod.GET, value="/userr/{idAgence}")
	public Iterable<User> showusersbyagence(@PathVariable String idAgence) {
		return (Iterable<User>) users.findAllByIdAgenceAndUserType(idAgence, "chef");
	}


	@RequestMapping(method=RequestMethod.GET, value="/users/check/{status}")
	public Iterable<User> showusersstatus(@PathVariable String status) {
		return (Iterable<User>) users.findAllByStatus(status);
	}





	@RequestMapping(method=RequestMethod.GET, value="/user/{id}")
	public Optional<User> show(@PathVariable String id) {
		return users.findById(id);
	}

}
