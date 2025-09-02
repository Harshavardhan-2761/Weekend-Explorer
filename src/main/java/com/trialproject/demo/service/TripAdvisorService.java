package com.trialproject.demo.service;

import com.trialproject.demo.model.Place;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.util.ArrayList;
import java.util.List;

@Service
public class TripAdvisorService {

    @Value("${tripadvisor.apiKey}")
    private String apiKey;

    @Value("${tripadvisor.apiHost}")
    private String apiHost;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper mapper = new ObjectMapper();

    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("x-rapidapi-key", apiKey);
        headers.set("x-rapidapi-host", apiHost);
        return headers;
    }

    /** 🔹 Nearby places */
    public List<Place> getNearbyPlaces(double lat, double lng, String type) {
        String url = "https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng"
                + "?latitude=" + lat
                + "&longitude=" + lng
                + "&limit=10";

        if ("hotel".equals(type)) {
            url = "https://travel-advisor.p.rapidapi.com/hotels/list-by-latlng"
                    + "?latitude=" + lat
                    + "&longitude=" + lng
                    + "&limit=10";
        } else if ("attraction".equals(type)) {
            url = "https://travel-advisor.p.rapidapi.com/attractions/list-by-latlng"
                    + "?latitude=" + lat
                    + "&longitude=" + lng
                    + "&limit=10";
        }

        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(getHeaders()), String.class);

        return parsePlaces(response.getBody(), type);
    }

    /** 🔹 Parse JSON into Place objects */
    private List<Place> parsePlaces(String json, String type) {
        List<Place> places = new ArrayList<>();
        try {
            JsonNode root = mapper.readTree(json);
            JsonNode dataArray = root.path("data");

            if (dataArray.isArray()) {
                for (JsonNode node : dataArray) {
                    Place place = new Place();
                    place.setId(node.path("location_id").asText());
                    place.setName(node.path("name").asText("Unknown"));
                    place.setType(type);
                    place.setImageUrl(
                            node.path("photo").path("images").path("medium").path("url").asText(
                                    "https://via.placeholder.com/400x200"
                            )
                    );
                    place.setPriceLevel(node.path("price_level").asText("N/A"));
                    place.setLatitude(node.path("latitude").asDouble());
                    place.setLongitude(node.path("longitude").asDouble());

                    // flag using country code
                    String countryCode = node.path("address_obj").path("country").asText("");
                    if (!countryCode.isEmpty()) {
                        place.setFlagUrl("https://flagcdn.com/48x36/" + countryCode.toLowerCase() + ".png");
                    }

                    places.add(place);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return places;
    }

    /** 🔹 Search places by name */
    public List<Place> searchPlaces(String query) {
        // String url = "https://travel-advisor.p.rapidapi.com/locations/search?query=" + query + "&limit=10";
        String url = "https://travel-advisor.p.rapidapi.com/locations/search?query=" + query + "&limit=30&location_id=1&sort=distance";

        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(getHeaders()), String.class);

        List<Place> results = new ArrayList<>();
        try {
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode dataArray = root.path("data");

            if (dataArray.isArray()) {
                for (JsonNode node : dataArray) {
                    JsonNode resultObj = node.path("result_object");
                    if (!resultObj.isMissingNode()) {
                        Place place = new Place();
                        place.setId(resultObj.path("location_id").asText());
                        place.setName(resultObj.path("name").asText("Unknown"));
                        place.setType(resultObj.path("category").path("key").asText("location"));
                        place.setImageUrl(
                                resultObj.path("photo").path("images").path("medium").path("url").asText(
                                        "https://via.placeholder.com/400x200"
                                )
                        );
                        place.setLatitude(resultObj.path("latitude").asDouble());
                        place.setLongitude(resultObj.path("longitude").asDouble());

                        String countryCode = resultObj.path("address_obj").path("country").asText("");
                        if (!countryCode.isEmpty()) {
                            place.setFlagUrl("https://flagcdn.com/48x36/" + countryCode.toLowerCase() + ".png");
                        }

                        results.add(place);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return results;
    }

    /** 🔹 Get Q&A for a location */
    public List<String> getPlaceQuestions(String locationId) {
        String url = "https://travel-advisor.p.rapidapi.com/questions/list?location_id=" + locationId + "&limit=5";

        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(getHeaders()), String.class);

        List<String> questions = new ArrayList<>();
        try {
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode dataArray = root.path("data");
            if (dataArray.isArray()) {
                for (JsonNode node : dataArray) {
                    questions.add(node.path("question").asText("No question"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    /** 🔹 Get attraction products */
    public List<String> getAttractionProducts(String locationId) {
        // String url = "https://travel-advisor.p.rapidapi.com/attractions/get-details?location_id=" + locationId;
        String url = "https://travel-advisor.p.rapidapi.com/attractions/get-details?location_id=" + locationId + "&lang=en_US";


        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(getHeaders()), String.class);

        List<String> products = new ArrayList<>();
        try {
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode dataArray = root.path("data");
            if (dataArray.isArray()) {
                for (JsonNode node : dataArray) {
                    products.add(node.path("title").asText("No product title"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
