import 'package:flutter/material.dart';

// Main function to run the application
void main() {
  runApp(const SkincareApp());
}

// The root widget of the application
class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Skintellect", // Application title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color for the app
        fontFamily: 'Inter', // Custom font
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adapts density based on platform
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent, // Custom app bar background color
          foregroundColor: Colors.white, // Custom app bar text color
          centerTitle: true, // Center app bar title
          elevation: 4, // Shadow beneath the app bar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color
            foregroundColor: Colors.white, // Button text color
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners for buttons
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded borders for text fields
            borderSide: const BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      home: const HomePage(), // Set HomePage as the initial screen
    );
  }
}

// Home Page of the application
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TeZxt("Skintellect"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
            children: [
              // Welcome message
              const Text(
                "Welcome to Skintellect!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Spacer
              const Text(
                "Your personalized guide to healthy skin.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // Spacer
              // Button to start the skin type quiz
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SkinQuizPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SkinQuizPage()),
                  );
                },
                child: const Text("Start Skin Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Skin Quiz Page - Stateful widget to manage form state
class SkinQuizPage extends StatefulWidget {
  const SkinQuizPage({super.key});

  @override
  _SkinQuizPageState createState() => _SkinQuizPageState();
}

// State class for SkinQuizPage
class _SkinQuizPageState extends State<SkinQuizPage> {
  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  String? _selectedSkinType; // Holds the selected skin type
  final List<String> _selectedConcerns = []; // Holds selected skin concerns

  // List of available skin types for the quiz
  final List<String> _skinTypes = [
    'Normal',
    'Oily',
    'Dry',
    'Combination',
    'Sensitive',
  ];

  // List of common skin concerns
  final List<String> _skinConcerns = [
    'Acne',
    'Aging',
    'Hyperpigmentation',
    'Redness',
    'Dullness',
    'Dehydration',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skin Type Quiz"),
      ),
      body: SingleChildScrollView( // Allows scrolling if content overflows
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
            children: [
              const Text(
                "What is your skin type?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10), // Spacer
              // Radio buttons for skin type selection
              ..._skinTypes.map((type) => RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: _selectedSkinType,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSkinType = value; // Update selected skin type
                  });
                },
                activeColor: Colors.blueAccent,
              )).toList(),
              const SizedBox(height: 30), // Spacer

              const Text(
                "What are your main skin concerns?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10), // Spacer
              // Checkboxes for skin concerns selection
              ..._skinConcerns.map((concern) => CheckboxListTile(
                title: Text(concern),
                value: _selectedConcerns.contains(concern),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedConcerns.add(concern); // Add concern if checked
                    } else {
                      _selectedConcerns.remove(concern); // Remove concern if unchecked
                    }
                  });
                },
                activeColor: Colors.blueAccent,
              )).toList(),
              const SizedBox(height: 40), // Spacer

              // Submit button for the quiz
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Validate if a skin type is selected
                      if (_selectedSkinType == null) {
                        _showDialog(context, "Validation Error", "Please select your skin type.");
                      } else {
                        // Navigate to recommendations page with selected data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecommendationsPage(
                              skinType: _selectedSkinType!,
                              concerns: _selectedConcerns,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Get Recommendations"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to show a dialog box
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message), // Corrected: 'content' instead of 'context'
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

// Recommendations Page - Displays routine based on quiz answers
class RecommendationsPage extends StatelessWidget {
  final String skinType; // User's selected skin type
  final List<String> concerns; // User's selected skin concerns

  const RecommendationsPage({
    super.key,
    required this.skinType,
    required this.concerns,
  });

  // Function to generate a basic routine based on skin type and concerns
  String _generateRoutine() {
    String routine = "Here's a basic routine for your $skinType skin:\n\n";

    routine += "Morning Routine:\n";
    routine += "1. Cleanser: Gentle, hydrating cleanser.\n";
    if (skinType == 'Oily' || concerns.contains('Acne')) {
      routine += "2. Treatment: Salicylic acid or Niacinamide serum (for oil/acne).\n";
    }
    routine += "3. Moisturizer: Lightweight, non-comedogenic.\n";
    routine += "4. Sunscreen: SPF 30+ (broad-spectrum).\n\n";

    routine += "Evening Routine:\n";
    routine += "1. Cleanser: Double cleanse if wearing makeup/sunscreen.\n";
    if (skinType == 'Dry' || concerns.contains('Aging') || concerns.contains('Dehydration')) {
      routine += "2. Treatment: Hyaluronic acid or Retinol (if suitable for aging/dryness).\n";
    } else if (concerns.contains('Hyperpigmentation')) {
      routine += "2. Treatment: Vitamin C or Alpha Arbutin serum.\n";
    }
    routine += "3. Moisturizer: Richer, more occlusive moisturizer.\n";
    routine += "4. Optional: Face oil or sleeping mask.\n\n";

    if (concerns.isNotEmpty) {
      routine += "Specific concerns addressed:\n";
      for (var concern in concerns) {
        routine += "- Focus on products targeting $concern.\n";
      }
    } else {
      routine += "No specific concerns selected, focusing on general skin health.\n";
    }

    routine += "\nRemember to patch test new products and consult a dermatologist for personalized advice!";
    return routine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Skincare Recommendations"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Based on your selections:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Text(
              "Skin Type: $skinType",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              "Concerns: ${concerns.isEmpty ? 'None selected' : concerns.join(', ')}",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            const Text(
              "Recommended Routine:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _generateRoutine(), // Generate and display the routine
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the quiz or home page
                },
                child: const Text("Go Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
