package com.hackathon.backendelemental.controller;

import com.hackathon.backendelemental.entity.AiInput;
import com.hackathon.backendelemental.repository.AiInputRepository;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@RestController
@RequestMapping("/api/audioReceiver")
public class AudioReceiveController {

    static final CopyOnWriteArrayList<SseEmitter> transcriptionEmitters = new CopyOnWriteArrayList<>();
    private static final String AUDIO_STORAGE_DIR = "C:/Users/Win11 Pro/Desktop/aiAudio/";
    @Autowired
    private AiInputRepository aiInputRepository;


    public AudioReceiveController() {
        // ensure the audio storage directory exists
        Path path = Paths.get(AUDIO_STORAGE_DIR);
        try {
            Files.createDirectories(path);
        } catch (IOException e) {
            throw new RuntimeException("Could not create audio storage directory", e);
        }
    }

    @GetMapping("/subscribe/transcriptions")
    public SseEmitter subscribeToTranscriptions() {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        transcriptionEmitters.add(emitter);

        emitter.onCompletion(() -> transcriptionEmitters.remove(emitter));
        emitter.onTimeout(() -> transcriptionEmitters.remove(emitter));
        emitter.onError(e -> transcriptionEmitters.remove(emitter));

        return emitter;
    }

    @PostMapping("/sendAudio")
    public ResponseEntity<?> receiveAudio(@RequestParam("audioFile") MultipartFile audioFile) {
        try {
            // save the audio file
            String fileName = System.currentTimeMillis() + "-" + audioFile.getOriginalFilename();
            Path filePath = Paths.get(AUDIO_STORAGE_DIR + fileName);
            Files.write(filePath, audioFile.getBytes());

            // save only the audio file path in the database
            AiInput aiInput = new AiInput();
            aiInput.setAudioFilePath(filePath.toString());
            aiInput.setUpdatedAt(LocalDateTime.now());
            aiInputRepository.save(aiInput);
            // notifyClients("New audio file uploaded!");
            // AudioController.fulfillPromise("123", filePath.toFile());
            //AudioController.notifyFlutterClients("New audio file available: " + fileName);


            return ResponseEntity.ok(Map.of("message", "Audio file saved successfully"));
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Error saving audio file");
        }
    }
//    private void notifyClients(String message) {
//        for (SseEmitter emitter : emitters) {
//            try {
//                emitter.send(SseEmitter.event().name("update").data(message));
//            } catch (IOException e) {
//                emitters.remove(emitter);
//            }
//        }
//    }

    @PostMapping("/sendTranscript")
    public ResponseEntity<?> receiveTranscript(@RequestParam("transcriptText") String transcriptText) {
        try {
            AiInput aiInput = new AiInput();
            aiInput.setTranscriptText(transcriptText);
            aiInput.setUpdatedAt(LocalDateTime.now());
            aiInputRepository.save(aiInput);
            //notifyClients("New transcript received!");

            return ResponseEntity.ok(Map.of("message", "Transcript saved successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error saving transcript text");
        }
    }

    @GetMapping("/getLatestAudio")
    public ResponseEntity<?> getLatestAudio() {

        try {
            Thread.sleep(10000);
            // fetch the most recently updated AIInput with an audio file
            AiInput latestInput = aiInputRepository.findFirstByOrderByUpdatedAtDesc();
            if (latestInput == null || latestInput.getAudioFilePath() == null) {
                return ResponseEntity.status(404).body("No audio files found");
            }

            File audioFile = new File(latestInput.getAudioFilePath());
            if (!audioFile.exists()) {
                return ResponseEntity.status(404).body("Audio file not found");
            }

//            return ResponseEntity.ok()
//                    .header("Content-Disposition", "attachment; filename=\"" + audioFile.getName() + "\"")
//                    .body(Files.readAllBytes(audioFile.toPath()));
            FFprobe ffprobe = new FFprobe("C:\\ProgramData\\chocolatey\\bin\\ffprobe.exe");
            FFmpegProbeResult probeResult = ffprobe.probe(audioFile.getAbsolutePath());
            long durationInMilliseconds = Math.round(probeResult.getFormat().duration * 1000);

            Path path = audioFile.toPath();
            return ResponseEntity.ok()
                    .header("Content-Type", Files.probeContentType(path)) // Set the correct MIME type
                    .header("Content-Disposition", "inline; filename=\"" + audioFile.getName() + "\"")
                    .header("Audio-Duration", String.valueOf(durationInMilliseconds)) // Add duration to headers
                    .body(new org.springframework.core.io.FileSystemResource(audioFile));
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Error retrieving audio file");
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
