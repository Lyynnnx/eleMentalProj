package com.hackathon.backendelemental.service;
//
//import org.apache.hc.client5.http.classic.methods.HttpPost;
//import org.apache.hc.client5.http.entity.mime.MultipartEntityBuilder;
//import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
//import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
//import org.apache.hc.client5.http.impl.classic.HttpClients;
//import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;

@Service
public class TranscriptionService {

    private static final String WHISPER_API_URL = "https://api.openai.com/v1/audio/transcriptions";
    private static String API_KEY = "";
    private final RestTemplate restTemplate;

    public TranscriptionService(RestTemplateBuilder restTemplateBuilder) throws IOException {
        this.restTemplate = restTemplateBuilder.build();
        //API_KEY = Files.readString(Paths.get("apikey.txt")).trim();
    }

    public String transcribe(File audioFile) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(API_KEY);
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new FileSystemResource(audioFile));
        body.add("model", "whisper-1");

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.exchange(
                WHISPER_API_URL,
                HttpMethod.POST,
                requestEntity,
                Map.class
        );

        Map<String, Object> responseMap = response.getBody();
        if (responseMap != null) {
            return (String) responseMap.get("text");
        } else {
            throw new Exception("Failed to get a response from the API");
        }
    }
}
