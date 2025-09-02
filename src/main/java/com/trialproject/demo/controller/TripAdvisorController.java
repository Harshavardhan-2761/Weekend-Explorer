package com.trialproject.demo.controller;

import com.trialproject.demo.model.Place;
import com.trialproject.demo.service.TripAdvisorService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
public class TripAdvisorController {

    private final TripAdvisorService service;

    public TripAdvisorController(TripAdvisorService service) {
        this.service = service;
    }

    @GetMapping("/nearby")
    public List<Place> getNearby(
            @RequestParam double lat,
            @RequestParam double lng,
            @RequestParam(defaultValue = "restaurant") String type) {
        return service.getNearbyPlaces(lat, lng, type);
    }

    @GetMapping("/search")
    public List<Place> search(@RequestParam String query) {
        return service.searchPlaces(query);
    }

    @GetMapping("/questions")
    public List<String> getQuestions(@RequestParam String locationId) {
        return service.getPlaceQuestions(locationId);
    }

    @GetMapping("/products")
    public List<String> getProducts(@RequestParam String locationId) {
        return service.getAttractionProducts(locationId);
    }
}
