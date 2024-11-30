package com.hackathon.backendelemental.controller;

import com.hackathon.backendelemental.entity.Evaluation;
import com.hackathon.backendelemental.entity.User;
import com.hackathon.backendelemental.entity.UserInput;
import com.hackathon.backendelemental.repository.EvaluationRepository;
import com.hackathon.backendelemental.repository.UserInputRepository;
import com.hackathon.backendelemental.service.TranscriptionService;
import com.hackathon.backendelemental.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import org.apache.commons.io.FilenameUtils;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;


@RestController
@RequestMapping("/api/audio")
public class AudioController {

    //private static final ConcurrentHashMap<String, CompletableFuture<File>> promiseMap = new ConcurrentHashMap<>();
    private static final String AUDIO_STORAGE_DIR = "C:/Users/Win11 Pro/Desktop/aiAudio/";
    private static final CopyOnWriteArrayList<SseEmitter> audioEmitters = new CopyOnWriteArrayList<>();
    @Autowired
    private TranscriptionService transcriptionService;
    @Autowired
    private UserInputRepository userInputRepository;
    @Autowired
    private EvaluationRepository evaluationRepository;
    @Autowired
    private UserService userService;

    public static void notifyPythonClients(String message) {
        for (SseEmitter emitter : AudioReceiveController.transcriptionEmitters) {
            try {
                emitter.send(SseEmitter.event().name("transcriptionUpdate").data(message));
            } catch (IOException e) {
                AudioReceiveController.transcriptionEmitters.remove(emitter);
            }
        }
    }

    public static void notifyFlutterClients(String message) {
        for (SseEmitter emitter : audioEmitters) {
            try {
                emitter.send(SseEmitter.event().name("audioUpdate").data(message));
            } catch (IOException e) {
                audioEmitters.remove(emitter);
            }
        }
    }

    @PostMapping("/transcribe")
    public ResponseEntity<?> uploadAndTranscribe(@RequestParam("audio_file") MultipartFile audioFile, HttpServletRequest request) {
        try {
            // save MultipartFile to a temporary file
            // File tempFile = convertToFile(audioFile);
            User loggedInUser = userService.findUserByEmail("sultan");
            if (loggedInUser == null) {
                return ResponseEntity.status(401).body("You are not logged in.");
            }
//            if (audioFile == null) {
//                UserInput userInput = new UserInput(loggedInUser.getId(), "exi", "A");
//                userService.saveUserInput(loggedInUser.getId(), "exit", "A");
//                return ResponseEntity.ok(Map.of("transcription","Thank you for the conversation!"));
//            }

            // call Whisper to transcribe the audio
            String transcription = transcriptionService.transcribe(convertToWav(audioFile));
            //String transcription = "Hello Popa";

            //User loggedInUser = (User) request.getSession().getAttribute("user");


            // Step 3: Save the transcription in the database

            UserInput userInput = new UserInput(loggedInUser.getId(), transcription, "A");
            userService.saveUserInput(loggedInUser.getId(), transcription, "A");

//            // Step 4: Return response
//            return ResponseEntity.ok(Map.of("transcription", transcription));
            // Create a CompletableFuture and store it
//            CompletableFuture<File> future = new CompletableFuture<>();
//            promiseMap.put("123", future);

            // Wait for the Python client to send back processed audio
            // File processedAudio = future.join();

            // Return the processed audio to the frontend
//            return ResponseEntity.ok()
//                    .header("Content-Disposition", "attachment; filename=\"" + processedAudio.getName() + "\"")
//                    .body(Files.readAllBytes(processedAudio.toPath()));
            //notifyPythonClients("New transcription available: " + transcription);

            return ResponseEntity.ok(Map.of("transcription", transcription));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error processing audio file");
        }
    }

    //    public static void fulfillPromise(String requestId, File processedFile) {
//        CompletableFuture<File> future = promiseMap.remove(requestId);
//        if (future != null) {
//            future.complete(processedFile);
//        }
//    }
    @GetMapping("/subscribe/audios")
    public SseEmitter subscribeToAudioUpdates() {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        audioEmitters.add(emitter);

        emitter.onCompletion(() -> audioEmitters.remove(emitter));
        emitter.onTimeout(() -> audioEmitters.remove(emitter));
        emitter.onError(e -> audioEmitters.remove(emitter));

        return emitter;
    }

    @GetMapping("/getTranscriptedText")
    public ResponseEntity<?> getTranscriptedText(HttpServletRequest request) {
        try {
            // Retrieve logged-in user from session
            User loggedInUser = (User) request.getSession().getAttribute("user");
            if (loggedInUser == null) {
                return ResponseEntity.status(401).body("You are not logged in.");
            }

            // Fetch latest transcription for the user
            UserInput latestTranscription = userService.getLatestTranscription(loggedInUser.getId());
            if (latestTranscription == null) {
                return ResponseEntity.status(404).body("No transcriptions found for this user.");
            }

            // Return the transcription as JSON
            //notifyClients("New transcription available!");
            return ResponseEntity.ok(latestTranscription);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while fetching the transcription.");
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
    @GetMapping("/getTranscriptedTextWithoutToken")
    public ResponseEntity<?> getTranscriptedTextWithoutToken() {
        try {

            UserInput latestTranscription = userService.getLatestTranscription(String.valueOf(new ObjectId("67487c3ccfbb08220b4fac5e")));
            if (latestTranscription == null) {
                return ResponseEntity.status(404).body("No transcriptions found for this user.");
            }
            userInputRepository.save(latestTranscription);

            //notifyClients("New transcription available!");
            return ResponseEntity.ok(latestTranscription);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while fetching the transcription.");
        }
    }

    public File convertToFile(MultipartFile multipartFile) throws Exception {
        Path tempDir = Paths.get("C:\\Users\\Win11 Pro\\Desktop\\tempAudio");
        Files.createDirectories(tempDir); // create if doesnt exist
        Path tempFile = Files.createTempFile(tempDir, "upload-", ".tmp");
        multipartFile.transferTo(tempFile.toFile());
        return tempFile.toFile();
    }

    public File convertToWav(MultipartFile multipartFile) throws Exception {

        // define a persistent location for saving the file
        Path tempDir = Paths.get("C:\\Users\\Win11 Pro\\Desktop\\tempAudio");
        Files.createDirectories(tempDir); // Create directory if it doesn't exist

        // create a new file in the temp directory
        Path tempFile = Files.createTempFile(tempDir, "upload-", ".aac");
        multipartFile.transferTo(tempFile.toFile()); // Save the file content

        // convert the AAC file to WAV using ffmpeg library
        File wavFile = new File(tempDir.toFile(), UUID.randomUUID().toString() + ".wav");
        FFmpeg ffmpeg = new FFmpeg("C:\\ProgramData\\chocolatey\\bin\\ffmpeg.exe");
        FFprobe ffprobe = new FFprobe("C:\\ProgramData\\chocolatey\\bin\\ffprobe.exe");


        FFmpegBuilder builder = new FFmpegBuilder()
                .setInput(tempFile.toString()) // input file(aac)
                .addOutput(wavFile.getAbsolutePath()) // output file
                .setFormat("wav") // format
                .done();

        FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
        executor.createJob(builder).run();

        // delete the original temporary AAC file
        Files.delete(tempFile);

        return wavFile;
    }

    @GetMapping("/getTranscriptedTextWithoutTokenNoJSON")
    public ResponseEntity<?> getTranscriptedTextWithoutTokenNoJSON() {
        try {
            UserInput latestTranscription = userService.getLatestTranscription(String.valueOf(new ObjectId("67487c3ccfbb08220b4fac5e")));
            if (latestTranscription == null) {
                return ResponseEntity.status(404).body("No transcriptions found for this user.");
            }

            return ResponseEntity.ok(latestTranscription.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while fetching the transcription.");
        }
    }

    @PostMapping("/postEvaluation")
    public ResponseEntity<?> receiveEvaluation(@RequestBody Map<String, Object> evaluationData) {
        try {
            int aspect1 = (Integer) evaluationData.get("Identification of Negative Thought");
            int aspect2 = (Integer) evaluationData.get("Challenge of Thought");
            int aspect3 = (Integer) evaluationData.get("Reframing the Thought");
            int aspect4 = (Integer) evaluationData.get("Testing the Reframed Thought");
            String text = (String) evaluationData.get("text");

            if (aspect1 < 1 || aspect1 > 5 || aspect2 < 1 || aspect2 > 5 ||
                    aspect3 < 1 || aspect3 > 5 || aspect4 < 1 || aspect4 > 5) {
                return ResponseEntity.badRequest().body("All aspects must have a value between 1 and 5.");
            }

            Evaluation evaluation = new Evaluation(aspect1, aspect2, aspect3, aspect4, text);
            evaluationRepository.save(evaluation);

            return ResponseEntity.ok(Map.of("message", "Evaluation saved successfully", "evaluation", evaluation));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while saving the evaluation.");
        }
    }

    @GetMapping("/getEvaluation")
    public ResponseEntity<?> getEvaluation() {
        try {
            Optional<Evaluation> evaluationOpt = Optional.ofNullable(evaluationRepository.findFirstByOrderByUpdatedAtDesc());

            if (evaluationOpt.isEmpty()) {
                return ResponseEntity.status(404).body("Evaluation not found for the given ID.");
            }

            return ResponseEntity.ok(evaluationOpt);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while fetching the evaluation.");
        }
    }
//    @GetMapping("/getEvaluation")
//    public ResponseEntity<?> getLatestEvaluation() {
//        try {
//            // Fetch the most recently added evaluation
//            Thread.sleep(5000);
//            Evaluation latestEvaluation = evaluationRepository.findFirstByOrderByCreatedAtDesc();
//
//            // Check if an evaluation exists
//            if (latestEvaluation == null) {
//                return ResponseEntity.status(404).body("No evaluations found.");
//            }
//
//            // Return the latest evaluation as JSON
//            return ResponseEntity.ok(latestEvaluation);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return ResponseEntity.status(500).body("An error occurred while fetching the latest evaluation.");
//        }
//
//    }
}