package com.zzuiksa.server.global.fcm;

import java.io.IOException;
import java.io.InputStream;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FcmService {

    @Value("${fcm.secret-key-path}")
    private String secretKeyPath;

    @Value("${fcm.project-id}")
    private String projectId;

    @PostConstruct
    public void initialize() throws IOException {
        InputStream secretKeyStream = new ClassPathResource(secretKeyPath).getInputStream();
        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(secretKeyStream))
                .setProjectId(projectId)
                .build();
        FirebaseApp.initializeApp(options);
    }

    public void sendMessageByToken(String title, String body, String token) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();
        Message message = Message.builder()
                .setNotification(notification)
                .setToken(token)
                .build();
        FirebaseMessaging.getInstance().send(message);
    }
}
