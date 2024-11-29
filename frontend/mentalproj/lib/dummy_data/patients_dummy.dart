import 'package:mentalproj/models/patient.dart';

String sigma(int age, String communicationStyle, String gender){
    return "Age: "+'$age'+ ", gender: "+gender+", communication style: "+communicationStyle;
}

List<Patient> patietnsDummy = [
  Patient(imgurl: 'assets/person1.jpg',
  name:"Johnny", backstory: sigma(28,"speaks slowly, often with long pauses, limited emotional range","male"), 

  communicationStyle: "Speaks slowly, often with long pauses, limited emotional range",
   gender: "Male",
  coreSypmtoms: ["persistent sadness",
                "loss of interest in previously enjoyed activities",
                "sleeping difficulties",
                "decreased energy",
                "difficulty concentrating"],
                diagnosis: "Major Depressive Disorder",
                occupation: "Graphic Designer",
                personalityTraits:["Detail-oriented", "Reserved"], age: 28),
  Patient(
    imgurl: 'assets/person2.jpg',
            name: "Aisha Malik",
            backstory: sigma(45,"guarded but articulate, occasionally tearful","female"),
            age: 45,
            gender: "Female",
            coreSypmtoms: ["Nightmares", "Hypervigilance", "Avoidance of trauma reminders"],
            diagnosis: "Post-Traumatic Stress Disorder",
            occupation: "Social Worker",
            communicationStyle: "Guarded but articulate, occasionally tearful",
            personalityTraits: ["Compassionate", "Resilient", "Prone to self-doubt"]
        ,),

    Patient(imgurl: 'assets/person3.jpg',
            name: "Liam O'Connor",
            backstory: sigma(29,"expressive and emotional, fluctuates between trust and defensiveness", "male"),
            age: 29,
            gender: "Male",
            coreSypmtoms: ["Intense fear of rejection", "Unstable relationships", "Chronic feelings of emptiness"],
            diagnosis: "Borderline Personality Disorder",
            occupation: "Freelance Photographer",
            communicationStyle: "Expressive and emotional, fluctuates between trust and defensiveness",
            personalityTraits: ["Creative", "Impulsive", "Sensitive"]
    ),

    Patient( imgurl: 'assets/person4.jpg',
            backstory: sigma(50,"precise, detail-focused, seeks reassurance", "female"),
            name: "Sophia Zhang",
            age: 50,
            gender: "Female",
            coreSypmtoms: ["Obsessive cleaning routines", "Intrusive thoughts of contamination", "Difficulty relaxing"],
            diagnosis: "Obsessive-Compulsive Disorder",
            occupation: "Accountant",
            communicationStyle: "Precise, detail-focused, seeks reassurance",
            personalityTraits: ["Conscientious", "Anxious", "Methodical"]
    ),

    Patient( 
            imgurl: 'assets/person5.JPG',
            backstory: sigma(34,"fast-paced, often tangential, enthusiastic", "male"),
            name: "Carlos Alvarez",
            age: 34,
            gender: "Male",
            coreSypmtoms: ["Difficulty concentrating", "Irritability", "Impulsive spending"],
            diagnosis: "Attention-Deficit/Hyperactivity Disorder (ADHD)",
            occupation: "Sales Representative",
            communicationStyle: "Fast-paced, often tangential, enthusiastic",
            personalityTraits: ["Outgoing", "Energetic", "Easily distracted"]
    ),


    Patient( 
            imgurl: 'assets/person5.JPG',
            backstory: sigma(28,"reserved, apologetic, struggles to make eye contact","female"),
            name: "Rachel Goldberg",
            age: 28,
            gender: "Female",
            coreSypmtoms: ["Extreme self-doubt", "Fear of judgment", "Avoidance of social interactions"],
            diagnosis: "Social Anxiety Disorder",
            occupation: "Graphic Designer",
            communicationStyle: "Reserved, apologetic, struggles to make eye contact",
            personalityTraits: ["Creative", "Conscientious", "Self-critical"]

    ),

    Patient( 
            imgurl: 'assets/person6.JPG',
            backstory: sigma(22,"quiet and hesitant, struggles to discuss eating habits openly","female"),
            name: "Olivia Bennett",
            age: 22,
            gender: "Female",
            coreSypmtoms: ["Extreme calorie restriction", "Intense fear of weight gain", "Distorted body image"],
            diagnosis: "Anorexia Nervosa",
            occupation: "University Student",
            communicationStyle: "Quiet and hesitant, struggles to discuss eating habits openly",
            personalityTraits: ["Perfectionistic", "Highly self-disciplined", "Reserved"]
    ),Patient( 
      imgurl: 'assets/person1.jpg',
      backstory: sigma(30,"disorganized, occasionally paranoid, fluctuates between openness and guardedness","male"),
      name: "James Peterson",
            age: 30,
            gender: "Male",
            coreSypmtoms: ["Auditory hallucinations", "Delusional beliefs about being watched", "Social withdrawal"],
            diagnosis: "Schizophrenia",
            occupation: "Unemployed",
            communicationStyle: "Disorganized, occasionally paranoid, fluctuates between openness and guardedness",
            personalityTraits: ["Thoughtful", "Creative", "Prone to mistrust"]
    ), 

    Patient( 
      imgurl: 'assets/person2.jpg',
      backstory: sigma(39,"defensive when discussing substance use, occasionally dismissive",'divarse'),
      name: "Samantha Torres",
            age: 39,
            gender: "Diverse",
            coreSypmtoms: ["Binge drinking", "Relationship conflicts due to alcohol use", "Denial about its impact on health"],
            diagnosis: "Alcohol Use Disorder",
            occupation: "Marketing Manager",
            communicationStyle: "Defensive when discussing substance use, occasionally dismissive",
            personalityTraits: ["Outgoing", "High-achieving", "Emotionally avoidant"]
    ),


    Patient( 
      imgurl: 'assets/person3.jpg',
      backstory: sigma(17,"reluctant to open up, occasionally tearful and overwhelmed","male"),
      name: "Daniel Adams",
            age: 17,
            gender: "Male",
            coreSypmtoms: ["Expressing hopelessness", "Thoughts of self-harm", "Withdrawal from friends and family"],
            diagnosis: "Acute Suicidality",
            occupation: "High School Student",
            communicationStyle: "Reluctant to open up, occasionally tearful and overwhelmed",
            personalityTraits: ["Sensitive", "Introspective", "Struggling with self-worth"]
    )


// Patient(imgurl: ,name:"Felix", backstory: 'sigma2'),
// Patient(,name:"misha", backstory: 'sigma3'),
// Patient(,name:"Kyrill", backstory: 'sigma4'),
// Patient(imgurl: 'assets/person5.JPG',name:"Vitek", backstory: 'sigma5'),
// Patient(imgurl: 'assets/person6.JPG',name:"Anton", backstory: 'sigma6'),

];