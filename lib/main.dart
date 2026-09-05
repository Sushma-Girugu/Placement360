import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Placement360App());
}

class Placement360App extends StatelessWidget {
  const Placement360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placement360',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        cardTheme: const CardThemeData(
          margin: EdgeInsets.only(bottom: 12),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

// ============================================================
// DATA MODELS
// ============================================================

class StudentProfile {
  String name;
  String branch;
  String cgpa;
  String tenth;
  String twelfth;
  String backlogs;
  int internshipMonths;

  StudentProfile({
    this.name = '',
    this.branch = 'Computer Science & Engineering',
    this.cgpa = '',
    this.tenth = '',
    this.twelfth = '',
    this.backlogs = '0',
    this.internshipMonths = 0,
  });
}

class ProjectData {
  final String domain;
  final String status;
  final String technologies;
  final String description;
  final int impact;

  ProjectData({
    required this.domain,
    required this.status,
    required this.technologies,
    required this.description,
    required this.impact,
  });
}

class Question {
  final String question;
  final List<String> options;
  final int answer;

  const Question(
    this.question,
    this.options,
    this.answer,
  );
}

// ============================================================
// BRANCHES
// ============================================================

const branches = <String>[
  'Computer Science & Engineering',
  'Information Technology',
  'Artificial Intelligence',
  'Data Science',
  'Electronics & Communication',
  'Electrical & Electronics',
  'Mechanical Engineering',
  'Civil Engineering',
  'Chemical Engineering',
  'Biotechnology',
];

// ============================================================
// CODING-RELEVANT BRANCHES
// ============================================================

const codingBranches = <String>{
  'Computer Science & Engineering',
  'Information Technology',
  'Artificial Intelligence',
  'Data Science',
};

// ============================================================
// BRANCH-SPECIFIC SKILLS
// ============================================================

final branchSkills = <String, List<String>>{
  'Computer Science & Engineering': [
    'Data Structures & Algorithms',
    'Object Oriented Programming',
    'Database / SQL',
    'Web Development',
    'Git & GitHub',
    'Operating Systems',
    'Computer Networks',
    'Problem Solving',
  ],

  'Information Technology': [
    'Data Structures & Algorithms',
    'Web Development',
    'Database / SQL',
    'Git & GitHub',
    'Cloud Computing',
    'Computer Networks',
    'Problem Solving',
    'Cybersecurity',
  ],

  'Artificial Intelligence': [
    'Python',
    'Machine Learning',
    'Deep Learning',
    'Data Structures & Algorithms',
    'Statistics',
    'Data Analysis',
    'SQL',
    'Git & GitHub',
  ],

  'Data Science': [
    'Python',
    'Statistics',
    'Machine Learning',
    'Data Analysis',
    'SQL',
    'Data Visualization',
    'Problem Solving',
    'Git & GitHub',
  ],

  'Electronics & Communication': [
    'Digital Electronics',
    'Analog Electronics',
    'Embedded Systems',
    'Microcontrollers',
    'Communication Systems',
    'PCB Design',
    'Signal Processing',
    'Programming',
  ],

  'Electrical & Electronics': [
    'Electrical Machines',
    'Power Systems',
    'Power Electronics',
    'Control Systems',
    'Electrical Measurements',
    'MATLAB / Simulink',
    'PLC / Automation',
    'Programming',
  ],

  'Mechanical Engineering': [
    'Engineering Drawing',
    'AutoCAD',
    'SolidWorks / CAD',
    'Thermodynamics',
    'Manufacturing',
    'Machine Design',
    'CNC / CAM',
    'Industrial Engineering',
  ],

  'Civil Engineering': [
    'AutoCAD',
    'STAAD.Pro',
    'ETABS',
    'Structural Analysis',
    'Surveying',
    'Construction Management',
    'Quantity Estimation',
    'Geotechnical Engineering',
  ],

  'Chemical Engineering': [
    'Process Design',
    'Thermodynamics',
    'Heat Transfer',
    'Mass Transfer',
    'Process Control',
    'Aspen / Simulation',
    'Chemical Safety',
    'Industrial Processes',
  ],

  'Biotechnology': [
    'Molecular Biology',
    'Genetics',
    'Microbiology',
    'Bioinformatics',
    'Bioprocessing',
    'Cell Culture',
    'Laboratory Techniques',
    'Data Analysis',
  ],
};

// ============================================================
// PROJECT DOMAINS
// IMPORTANT: These are PROJECT DOMAINS, not project titles.
// ============================================================

final projectDomains = <String, List<String>>{
  'Computer Science & Engineering': [
    'Web Application',
    'Mobile Application',
    'Cloud Application',
    'Cybersecurity',
    'AI / Machine Learning',
    'Database System',
    'Automation',
  ],

  'Information Technology': [
    'Web Application',
    'Cloud Computing',
    'Cybersecurity',
    'Database System',
    'Mobile Application',
    'Network Application',
    'Automation',
  ],

  'Artificial Intelligence': [
    'Machine Learning',
    'Deep Learning',
    'Natural Language Processing',
    'Computer Vision',
    'Recommendation System',
    'Generative AI',
    'Predictive Analytics',
  ],

  'Data Science': [
    'Data Analytics',
    'Machine Learning',
    'Predictive Analytics',
    'Business Intelligence',
    'Recommendation System',
    'Data Visualization',
    'Forecasting',
  ],

  'Electronics & Communication': [
    'Embedded Systems',
    'IoT',
    'Robotics',
    'Communication System',
    'PCB / Hardware',
    'Signal Processing',
    'VLSI',
  ],

  'Electrical & Electronics': [
    'Power Systems',
    'Renewable Energy',
    'Electrical Automation',
    'Power Electronics',
    'IoT',
    'Control Systems',
    'Smart Grid',
  ],

  'Mechanical Engineering': [
    'CAD / Product Design',
    'Manufacturing',
    'Robotics',
    'Automation',
    'Automotive',
    'Thermal Engineering',
    'Industrial Engineering',
  ],

  'Civil Engineering': [
    'Structural Design',
    'Construction Management',
    'Smart Infrastructure',
    'Transportation',
    'Geotechnical Engineering',
    'Water Resources',
    'Quantity Estimation',
  ],

  'Chemical Engineering': [
    'Process Design',
    'Process Optimization',
    'Chemical Simulation',
    'Process Control',
    'Energy Systems',
    'Environmental Engineering',
    'Industrial Safety',
  ],

  'Biotechnology': [
    'Bioinformatics',
    'Bioprocessing',
    'Drug Discovery',
    'Healthcare Analytics',
    'Genomics',
    'Microbiology',
    'Biotechnology Research',
  ],
};

// ============================================================
// CAREER ROLES
// ============================================================

final careerRoles = <String, List<String>>{
  'Computer Science & Engineering': [
    'Software Engineer',
    'Backend Developer',
    'Frontend Developer',
    'Full Stack Developer',
    'Cloud Engineer',
    'QA Engineer',
  ],

  'Information Technology': [
    'Software Engineer',
    'IT Engineer',
    'Cloud Engineer',
    'Cybersecurity Analyst',
    'System Engineer',
    'Web Developer',
  ],

  'Artificial Intelligence': [
    'ML Engineer',
    'AI Engineer',
    'Data Scientist',
    'Computer Vision Engineer',
    'NLP Engineer',
    'AI Software Engineer',
  ],

  'Data Science': [
    'Data Scientist',
    'Data Analyst',
    'ML Engineer',
    'Business Analyst',
    'Data Engineer',
    'BI Analyst',
  ],

  'Electronics & Communication': [
    'Embedded Engineer',
    'Electronics Engineer',
    'VLSI Engineer',
    'IoT Engineer',
    'Hardware Engineer',
    'Communication Engineer',
  ],

  'Electrical & Electronics': [
    'Electrical Engineer',
    'Power Systems Engineer',
    'Control Engineer',
    'Automation Engineer',
    'Power Electronics Engineer',
    'Electrical Design Engineer',
  ],

  'Mechanical Engineering': [
    'Mechanical Design Engineer',
    'Manufacturing Engineer',
    'Production Engineer',
    'Automotive Engineer',
    'CAD Engineer',
    'Quality Engineer',
  ],

  'Civil Engineering': [
    'Structural Engineer',
    'Site Engineer',
    'Construction Engineer',
    'Planning Engineer',
    'Quantity Surveyor',
    'Civil Design Engineer',
  ],

  'Chemical Engineering': [
    'Process Engineer',
    'Production Engineer',
    'Chemical Engineer',
    'Process Control Engineer',
    'Safety Engineer',
    'Quality Engineer',
  ],

  'Biotechnology': [
    'Bioprocess Engineer',
    'Research Associate',
    'Bioinformatics Analyst',
    'Clinical Research Associate',
    'Biotech Analyst',
    'Laboratory Scientist',
  ],
};

// ============================================================
// BRANCH-SPECIFIC ASSESSMENTS
// ============================================================

final branchQuestions = <String, List<Question>>{
  'Computer Science & Engineering': const [
    Question(
      'Which data structure follows LIFO?',
      ['Queue', 'Stack', 'Heap', 'Graph'],
      1,
    ),
    Question(
      'Which SQL command retrieves data?',
      ['SELECT', 'PUSH', 'FETCHALL', 'READ'],
      0,
    ),
    Question(
      'Which concept allows one interface with multiple implementations?',
      ['Inheritance', 'Polymorphism', 'Compilation', 'Caching'],
      1,
    ),
    Question(
      'Which protocol is commonly used for secure web traffic?',
      ['HTTP', 'FTP', 'HTTPS', 'SMTP'],
      2,
    ),
    Question(
      'What is the average time complexity of binary search?',
      ['O(n)', 'O(log n)', 'O(n²)', 'O(1)'],
      1,
    ),
  ],

  'Information Technology': const [
    Question(
      'Which layer handles IP addressing in the OSI model?',
      ['Application', 'Transport', 'Network', 'Physical'],
      2,
    ),
    Question(
      'Which SQL command changes existing rows?',
      ['UPDATE', 'CREATE', 'SELECT', 'GRANT'],
      0,
    ),
    Question(
      'Which practice tracks changes to source code?',
      ['Version control', 'Rendering', 'Parsing', 'Encryption'],
      0,
    ),
    Question(
      'What does DNS mainly resolve?',
      [
        'Files to folders',
        'Names to IP addresses',
        'Passwords to users',
        'Ports to cables'
      ],
      1,
    ),
    Question(
      'Which is an example of cloud infrastructure?',
      ['IaaS', 'BIOS', 'ALU', 'ASCII'],
      0,
    ),
  ],

  'Artificial Intelligence': const [
    Question(
      'Which task is supervised learning?',
      [
        'Clustering unlabeled data',
        'Predicting a labeled class',
        'Random sampling',
        'Hashing'
      ],
      1,
    ),
    Question(
      'Which metric is common for classification?',
      ['Accuracy', 'Voltage', 'Latency only', 'Torque'],
      0,
    ),
    Question(
      'What does overfitting mean?',
      [
        'Model memorizes training patterns and generalizes poorly',
        'Model has no parameters',
        'Data has no labels',
        'Training never starts'
      ],
      0,
    ),
    Question(
      'Which field is strongly related to image understanding?',
      ['Computer Vision', 'Compilers', 'Networking', 'CAD'],
      0,
    ),
    Question(
      'Why is feature scaling often used?',
      [
        'To put numerical features on comparable scales',
        'To delete labels',
        'To create hardware',
        'To increase file size'
      ],
      0,
    ),
  ],

  'Data Science': const [
    Question(
      'What does a median describe?',
      [
        'A central value',
        'A database server',
        'A programming language',
        'A network protocol'
      ],
      0,
    ),
    Question(
      'Which tool is commonly used for tabular data analysis in Python?',
      ['Pandas', 'Flutter', 'Gradle', 'Maven'],
      0,
    ),
    Question(
      'What is a correlation measure used for?',
      [
        'Association between variables',
        'Compiling code',
        'Routing packets',
        'Drawing CAD models'
      ],
      0,
    ),
    Question(
      'Which chart is useful for distributions?',
      ['Histogram', 'Logo', 'Flowchart only', 'Network cable'],
      0,
    ),
    Question(
      'What is a test set mainly used for?',
      [
        'Evaluating generalization',
        'Writing source code',
        'Creating backups only',
        'Installing drivers'
      ],
      0,
    ),
  ],

  'Electronics & Communication': const [
    Question(
      'What does a microcontroller typically contain?',
      [
        'CPU, memory and peripherals',
        'Only a resistor',
        'Only a battery',
        'Only an antenna'
      ],
      0,
    ),
    Question(
      'Which component stores electrical charge?',
      ['Capacitor', 'Transformer', 'Diode only', 'Switch only'],
      0,
    ),
    Question(
      'PCB stands for?',
      [
        'Printed Circuit Board',
        'Power Control Battery',
        'Program Cable Bus',
        'Primary Current Block'
      ],
      0,
    ),
    Question(
      'Which system converts analog signals into digital values?',
      ['ADC', 'DAC', 'Relay', 'Fuse'],
      0,
    ),
    Question(
      'Which area deals with wireless signal transmission?',
      [
        'Communication Systems',
        'Thermodynamics',
        'Surveying',
        'Accounting'
      ],
      0,
    ),
  ],

  'Electrical & Electronics': const [
    Question(
      'Which device converts AC to DC?',
      ['Rectifier', 'Inverter', 'Motor', 'Relay'],
      0,
    ),
    Question(
      'What does PLC commonly control?',
      [
        'Industrial automation processes',
        'Web pages',
        'SQL tables',
        'CAD drawings'
      ],
      0,
    ),
    Question(
      'Which machine converts electrical energy to mechanical energy?',
      ['Motor', 'Transformer', 'Capacitor', 'Rectifier'],
      0,
    ),
    Question(
      'What is a major purpose of a control system?',
      [
        'Regulate system behavior',
        'Store source code',
        'Render images',
        'Manage databases'
      ],
      0,
    ),
    Question(
      'Which tool is widely used for electrical simulation and modeling?',
      ['MATLAB / Simulink', 'Photoshop', 'HTML', 'Git only'],
      0,
    ),
  ],

  'Mechanical Engineering': const [
    Question(
      'Which CAD tool is used for 3D mechanical design?',
      ['SolidWorks', 'Excel', 'Wireshark', 'Figma'],
      0,
    ),
    Question(
      'Which process removes material using a rotating cutter?',
      ['Milling', 'Casting', 'Forging only', 'Welding'],
      0,
    ),
    Question(
      'What does CNC stand for?',
      [
        'Computer Numerical Control',
        'Central Network Controller',
        'Computer Node Cache',
        'Control Number Circuit'
      ],
      0,
    ),
    Question(
      'Thermodynamics primarily studies?',
      [
        'Energy, heat and work',
        'Databases',
        'Wireless protocols',
        'Source control'
      ],
      0,
    ),
    Question(
      'Engineering drawings mainly communicate?',
      [
        'Design dimensions and manufacturing information',
        'Passwords',
        'Web routes',
        'Database schemas'
      ],
      0,
    ),
  ],

  'Civil Engineering': const [
    Question(
      'Which software is widely used for structural analysis?',
      ['STAAD.Pro', 'Git', 'Wireshark', 'Android Studio'],
      0,
    ),
    Question(
      'What does surveying primarily determine?',
      [
        'Positions and measurements of points',
        'Database indexes',
        'CPU speed',
        'Network latency'
      ],
      0,
    ),
    Question(
      'Which software is commonly used for building structural modeling?',
      ['ETABS', 'Postman', 'Jenkins', 'Flutter'],
      0,
    ),
    Question(
      'Quantity estimation is mainly used to determine?',
      [
        'Material quantities and costs',
        'Internet speed',
        'CPU temperature',
        'Code complexity'
      ],
      0,
    ),
    Question(
      'Geotechnical engineering focuses on?',
      [
        'Soil and foundation behavior',
        'Mobile applications',
        'Database queries',
        'Machine learning'
      ],
      0,
    ),
  ],

  'Chemical Engineering': const [
    Question(
      'Which operation separates components by volatility?',
      ['Distillation', 'Surveying', 'Milling', 'Rendering'],
      0,
    ),
    Question(
      'Heat transfer studies movement of?',
      ['Thermal energy', 'Source code', 'Network packets', 'Concrete'],
      0,
    ),
    Question(
      'Process control is mainly concerned with?',
      [
        'Maintaining process variables',
        'Designing websites',
        'Editing images',
        'Writing resumes'
      ],
      0,
    ),
    Question(
      'Which tool is used for chemical process simulation?',
      ['Aspen', 'GitHub', 'Figma', 'Flutter'],
      0,
    ),
    Question(
      'Why is chemical safety important?',
      [
        'To control hazards and protect people/processes',
        'To increase file size',
        'To speed up Wi-Fi',
        'To design databases'
      ],
      0,
    ),
  ],

  'Biotechnology': const [
    Question(
      'DNA primarily carries?',
      [
        'Genetic information',
        'Electrical current',
        'Mechanical torque',
        'Network packets'
      ],
      0,
    ),
    Question(
      'Which field studies microorganisms?',
      ['Microbiology', 'Thermodynamics', 'Surveying', 'Networking'],
      0,
    ),
    Question(
      'Bioinformatics combines biology with?',
      [
        'Computational/data analysis',
        'Civil construction',
        'Power systems',
        'Machining'
      ],
      0,
    ),
    Question(
      'Cell culture involves growing?',
      [
        'Cells under controlled conditions',
        'Steel parts',
        'Concrete slabs',
        'Network services'
      ],
      0,
    ),
    Question(
      'Bioprocessing is associated with?',
      [
        'Using biological systems to produce useful products',
        'CAD drafting',
        'Packet routing',
        'Power transmission'
      ],
      0,
    ),
  ],
};

// ============================================================
// MAIN HOME
// ============================================================

class PlacementHome extends StatefulWidget {
  const PlacementHome({super.key});

  @override
  State<PlacementHome> createState() => _PlacementHomeState();
}

class _PlacementHomeState extends State<PlacementHome> {
  int selectedIndex = 0;

  final student = StudentProfile();
  final projects = <ProjectData>[];
  final skillLevels = <String, int>{};

  String primaryLanguage = 'Java';

  int assessmentScore = 0;
  bool assessmentTaken = false;

  // Self-reported communication confidence.
  int communicationScore = 0;

  bool isLoading = true;
  bool isSaving = false;

  bool get codingRelevant =>
      codingBranches.contains(student.branch);

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() => isLoading = false);
      }
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;

        student.name = (data['name'] ?? user.displayName ?? '').toString();
        student.branch = branches.contains(data['branch'])
            ? data['branch'].toString()
            : branches.first;

        student.cgpa = (data['cgpa'] ?? '').toString();
        student.tenth = (data['tenth'] ?? '').toString();
        student.twelfth = (data['twelfth'] ?? '').toString();
        student.backlogs = (data['backlogs'] ?? '0').toString();

        final internshipValue = data['internshipMonths'];
        student.internshipMonths = internshipValue is num
            ? internshipValue.toInt()
            : int.tryParse('$internshipValue') ?? 0;

        final loadedCommunication = data['communicationScore'];
        communicationScore = loadedCommunication is num
            ? loadedCommunication.toInt().clamp(0, 100).toInt()
            : (int.tryParse('$loadedCommunication')?.clamp(0, 100) ?? 0)
                .toInt();

        final loadedLanguage = (data['primaryLanguage'] ?? 'Java').toString();
        const languages = [
          'Java',
          'Python',
          'C',
          'C++',
          'JavaScript',
          'Dart',
        ];
        primaryLanguage =
            languages.contains(loadedLanguage) ? loadedLanguage : 'Java';

        final loadedAssessment = data['assessmentScore'];
        assessmentScore = loadedAssessment is num
            ? loadedAssessment.toInt().clamp(0, 100).toInt()
            : (int.tryParse('$loadedAssessment')?.clamp(0, 100) ?? 0)
                .toInt();

        assessmentTaken = data['assessmentTaken'] == true;

        skillLevels.clear();
        final rawSkills = data['skillLevels'];
        if (rawSkills is Map) {
          rawSkills.forEach((key, value) {
            if (value is num) {
              skillLevels[key.toString()] =
                  value.toInt().clamp(0, 5);
            }
          });
        }

        projects.clear();
        final rawProjects = data['projects'];
        if (rawProjects is List) {
          for (final item in rawProjects) {
            if (item is Map) {
              projects.add(
                ProjectData(
                  domain: (item['domain'] ?? '').toString(),
                  status: (item['status'] ?? 'Completed').toString(),
                  technologies: (item['technologies'] ?? '').toString(),
                  description: (item['description'] ?? '').toString(),
                  impact: (item['impact'] is num)
                      ? (item['impact'] as num).toInt().clamp(1, 5).toInt()
                      : (int.tryParse('${item['impact']}')?.clamp(1, 5) ?? 3)
                          .toInt(),
                ),
              );
            }
          }
        }
      } else {
        student.name = user.displayName ?? '';
        await _saveToFirestore(showMessage: false);
      }
    } catch (e) {
      if (mounted) {
        _showMessage(
          'Could not load your saved profile. You can continue and save again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _saveToFirestore({bool showMessage = true}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      if (mounted) {
        setState(() => isSaving = true);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'name': student.name,
          'email': user.email ?? '',
          'branch': student.branch,
          'cgpa': student.cgpa,
          'tenth': student.tenth,
          'twelfth': student.twelfth,
          'backlogs': student.backlogs,
          'internshipMonths': student.internshipMonths,
          'communicationScore': communicationScore,
          'primaryLanguage': primaryLanguage,
          'assessmentScore': assessmentScore,
          'assessmentTaken': assessmentTaken,
          'skillLevels': skillLevels,
          'projects': projects
              .map(
                (project) => {
                  'domain': project.domain,
                  'status': project.status,
                  'technologies': project.technologies,
                  'description': project.description,
                  'impact': project.impact,
                },
              )
              .toList(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      if (showMessage && mounted) {
        _showMessage('Your Placement360 data was saved.');
      }
    } catch (e) {
      if (showMessage && mounted) {
        _showMessage(
          'Could not save your data. Please check your internet connection.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  Future<void> refresh() async {
    setState(() {});
    await _saveToFirestore(showMessage: false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final pages = [
      DashboardPage(
        student: student,
        projects: projects,
        skillLevels: skillLevels,
        assessmentScore: assessmentScore,
        assessmentTaken: assessmentTaken,
        communicationScore: communicationScore,
        codingRelevant: codingRelevant,
        onNavigate: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      ProfilePage(
        student: student,
        communicationScore: communicationScore,
        onCommunicationChanged: (value) {
          setState(() {
            communicationScore = value;
          });
          _saveToFirestore(showMessage: false);
        },
        onChanged: refresh,
      ),
      SkillsPage(
        student: student,
        skillLevels: skillLevels,
        codingRelevant: codingRelevant,
        primaryLanguage: primaryLanguage,
        onLanguageChanged: (value) {
          setState(() {
            primaryLanguage = value;
          });
          _saveToFirestore(showMessage: false);
        },
        onChanged: refresh,
      ),
      AssessmentPage(
        branch: student.branch,
        score: assessmentScore,
        taken: assessmentTaken,
        onCompleted: (score) {
          setState(() {
            assessmentScore = score;
            assessmentTaken = true;
          });
          _saveToFirestore(showMessage: false);
        },
      ),
      ProjectsPage(
        student: student,
        projects: projects,
        onChanged: refresh,
      ),
      RoadmapPage(
        student: student,
        skillLevels: skillLevels,
        projects: projects,
        assessmentScore: assessmentScore,
        assessmentTaken: assessmentTaken,
        codingRelevant: codingRelevant,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_outlined),
            selectedIcon: Icon(Icons.psychology),
            label: 'Skills',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Assessment',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: 'Roadmap',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardPage extends StatelessWidget {
  final StudentProfile student;
  final List<ProjectData> projects;
  final Map<String, int> skillLevels;
  final int assessmentScore;
  final bool assessmentTaken;
  final int communicationScore;
  final bool codingRelevant;
  final ValueChanged<int> onNavigate;

  const DashboardPage({
    super.key,
    required this.student,
    required this.projects,
    required this.skillLevels,
    required this.assessmentScore,
    required this.assessmentTaken,
    required this.communicationScore,
    required this.codingRelevant,
    required this.onNavigate,
  });

  double get placementScore {
    final cgpa =
        (double.tryParse(student.cgpa) ?? 0).clamp(0, 10);

    final tenth =
        (double.tryParse(student.tenth) ?? 0).clamp(0, 100);

    final twelfth =
        (double.tryParse(student.twelfth) ?? 0).clamp(0, 100);

    final backlog =
        int.tryParse(student.backlogs) ?? 0;

    // Academic score
    final academic =
        (cgpa / 10) * 70 +
        (tenth / 100) * 15 +
        (twelfth / 100) * 15;

    final academicPart = academic * 0.20;

    // Branch-specific skills
    final skillAverage = skillLevels.isEmpty
        ? 0.0
        : skillLevels.values.fold<int>(
              0,
              (a, b) => a + b,
            ) /
            (skillLevels.length * 5);

    final skillPart = skillAverage * 25;

    // Projects
    final projectPart = projects.isEmpty
        ? 0.0
        : (projects
                    .map((p) => p.impact)
                    .fold<int>(0, (a, b) => a + b) /
                (projects.length * 5)) *
            20;

    // Internship
    final internshipPart =
        (student.internshipMonths.clamp(0, 12) / 12) * 10;

    // Assessment
    final assessmentPart = assessmentTaken
        ? (assessmentScore / 100) * 15
        : 0;

    // Communication
    final communicationPart =
        (communicationScore / 100) * 5;

    double score;

    if (codingRelevant) {
      // Software-oriented branches
      score = academicPart +
          skillPart +
          projectPart +
          internshipPart +
          assessmentPart +
          communicationPart;
    } else {
      // Core branches
      // Coding is NOT treated as a placement gate.
      score = academicPart +
          skillPart +
          projectPart +
          internshipPart +
          assessmentPart +
          communicationPart;
    }

    // Backlog penalty
    score -= backlog * 2.5;

    return score.clamp(0, 100);
  }

  String get readiness {
    if (placementScore >= 80) {
      return 'Highly Prepared';
    }

    if (placementScore >= 65) {
      return 'Placement Ready';
    }

    if (placementScore >= 45) {
      return 'Needs Improvement';
    }

    return 'Needs Attention';
  }

  List<Map<String, String>> get recommendations {
    final result = <Map<String, String>>[];

    final cgpa =
        double.tryParse(student.cgpa) ?? 0;

    final average = skillLevels.isEmpty
        ? 0.0
        : skillLevels.values.reduce((a, b) => a + b) /
            skillLevels.length;

    if (cgpa < 7) {
      result.add({
        'title': 'Improve academics',
        'text':
            'Your academic score is reducing your readiness. Maintain your CGPA and clear backlogs.',
      });
    }

    if (skillLevels.isEmpty || average < 3) {
      result.add({
        'title': 'Strengthen technical skills',
        'text': codingRelevant
            ? 'Build stronger programming, problem-solving and software fundamentals.'
            : 'Focus on the core engineering skills and tools expected in your branch.',
      });
    }

    if (projects.isEmpty) {
      result.add({
        'title': 'Build a real-world project',
        'text':
            'Add at least one project that solves a practical problem related to your branch.',
      });
    }

    if (student.internshipMonths == 0) {
      result.add({
        'title': 'Gain practical exposure',
        'text':
            'Look for internships, industrial training, research work or relevant practical experience.',
      });
    }

    if (!assessmentTaken || assessmentScore < 60) {
      result.add({
        'title': 'Complete the assessment',
        'text':
            'Take the branch-specific assessment to measure technical readiness.',
      });
    }

    if (result.isEmpty) {
      result.add({
        'title': 'Maintain your momentum',
        'text':
            'Your profile is balanced. Continue improving projects, skills and interview readiness.',
      });
    }

    return result.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    final roles = careerRoles[student.branch] ??
        const ['General Graduate Roles'];

    final score = placementScore;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement360'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Placement Readiness',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 6),

            Text(
              student.name.isEmpty
                  ? 'Complete your profile to get a personalized readiness analysis.'
                  : 'Welcome, ${student.name}',
            ),

            const SizedBox(height: 20),

            _ScoreCard(
              score: score,
              readiness: readiness,
            ),

            const SizedBox(height: 20),

            const _SectionTitle(
              title: 'Your Placement Path',
            ),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.school),
                ),
                title: Text(student.branch),
                subtitle: Text(
                  codingRelevant
                      ? 'Software / technology-oriented pathway'
                      : 'Core engineering / domain-oriented pathway',
                ),
              ),
            ),

            const SizedBox(height: 20),

            const _SectionTitle(
              title: 'Recommended Roles',
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: roles
                  .map(
                    (role) => Chip(
                      avatar: const Icon(
                        Icons.work_outline,
                        size: 18,
                      ),
                      label: Text(role),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            const _SectionTitle(
              title: 'Profile Snapshot',
            ),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.55,
              children: [
                _StatCard(
                  title: 'Projects',
                  value: '${projects.length}',
                  icon: Icons.folder,
                  onTap: () => onNavigate(4),
                ),

                _StatCard(
                  title: 'Skills Rated',
                  value: '${skillLevels.length}',
                  icon: Icons.psychology,
                  onTap: () => onNavigate(2),
                ),

                _StatCard(
                  title: 'Internship',
                  value:
                      '${student.internshipMonths} mo',
                  icon: Icons.business_center,
                  onTap: () => onNavigate(1),
                ),

                _StatCard(
                  title: 'Assessment',
                  value: assessmentTaken
                      ? '$assessmentScore%'
                      : 'Not taken',
                  icon: Icons.assignment,
                  onTap: () => onNavigate(3),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Why this score?',
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    _BreakdownRow(
                      'Academics',
                      _academicScore(),
                      20,
                    ),

                    _BreakdownRow(
                      'Branch Skills',
                      _skillScore(),
                      25,
                    ),

                    _BreakdownRow(
                      'Projects',
                      _projectScore(),
                      20,
                    ),

                    _BreakdownRow(
                      'Industry Exposure',
                      (student.internshipMonths
                                  .clamp(0, 12) /
                              12) *
                          10,
                      10,
                    ),

                    _BreakdownRow(
                      'Branch Assessment',
                      assessmentTaken
                          ? (assessmentScore / 100) * 15
                          : 0,
                      15,
                    ),

                    _BreakdownRow(
                      'Communication',
                      (communicationScore / 100) * 5,
                      5,
                    ),

                    if ((int.tryParse(
                              student.backlogs,
                            ) ??
                            0) >
                        0)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 8),
                          child: Text(
                            'Backlog adjustment: readiness is reduced for each active backlog.',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const _SectionTitle(
              title: 'What You Should Improve',
            ),

            ...recommendations.map(
              (recommendation) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.tips_and_updates_outlined,
                  ),
                  title: Text(
                    recommendation['title']!,
                  ),
                  subtitle: Text(
                    recommendation['text']!,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => onNavigate(5),
                icon: const Icon(Icons.route),
                label: const Text(
                  'View My Placement Roadmap',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _academicScore() {
    final cgpa =
        (double.tryParse(student.cgpa) ?? 0)
            .clamp(0, 10);

    final tenth =
        (double.tryParse(student.tenth) ?? 0)
            .clamp(0, 100);

    final twelfth =
        (double.tryParse(student.twelfth) ?? 0)
            .clamp(0, 100);

    return ((cgpa / 10) * 70 +
            (tenth / 100) * 15 +
            (twelfth / 100) * 15) *
        0.20;
  }

  double _skillScore() {
    if (skillLevels.isEmpty) {
      return 0;
    }

    return (skillLevels.values.fold<int>(
              0,
              (a, b) => a + b,
            ) /
            (skillLevels.length * 5)) *
        25;
  }

  double _projectScore() {
    if (projects.isEmpty) {
      return 0;
    }

    return (projects
                .map((p) => p.impact)
                .fold<int>(0, (a, b) => a + b) /
            (projects.length * 5)) *
        20;
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

class ProfilePage extends StatefulWidget {
  final StudentProfile student;
  final int communicationScore;
  final ValueChanged<int> onCommunicationChanged;
  final VoidCallback onChanged;

  const ProfilePage({
    super.key,
    required this.student,
    required this.communicationScore,
    required this.onCommunicationChanged,
    required this.onChanged,
  });

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController name;
  late final TextEditingController cgpa;
  late final TextEditingController tenth;
  late final TextEditingController twelfth;
  late final TextEditingController backlogs;

  double communicationConfidence = 0.0;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(
      text: widget.student.name,
    );

    cgpa = TextEditingController(
      text: widget.student.cgpa,
    );

    tenth = TextEditingController(
      text: widget.student.tenth,
    );

    twelfth = TextEditingController(
      text: widget.student.twelfth,
    );

    backlogs = TextEditingController(
      text: widget.student.backlogs,
    );

    communicationConfidence =
        widget.communicationScore.toDouble();
  }

  @override
  void dispose() {
    name.dispose();
    cgpa.dispose();
    tenth.dispose();
    twelfth.dispose();
    backlogs.dispose();

    super.dispose();
  }

  Future<void> _showInvalidValueAlert(String message) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 34,
          ),
          title: const Text(
            'Invalid Value',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMissingFieldsAlert(List<String> fields) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.info_outline,
            size: 34,
          ),
          title: const Text(
            'Required Fields Missing',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            fields.length == 1
                ? 'Please fill the required field before continuing:\n\n• ${fields.first}'
                : 'Please fill all the required fields before continuing:\n\n${fields.map((field) => '• $field').join('\n')}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showNormalMessage(String title, String message) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.info_outline),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> save() async {
    // ----------------------------------------------------------
    // 1. CHECK MISSING REQUIRED FIELDS FIRST
    // ----------------------------------------------------------
    final missingFields = <String>[];

    if (name.text.trim().isEmpty) {
      missingFields.add('Student Name');
    }

    if (cgpa.text.trim().isEmpty) {
      missingFields.add('CGPA');
    }

    if (tenth.text.trim().isEmpty) {
      missingFields.add('10th Percentage');
    }

    if (twelfth.text.trim().isEmpty) {
      missingFields.add('12th Percentage');
    }

    if (backlogs.text.trim().isEmpty) {
      missingFields.add('Number of Backlogs');
    }

    if (missingFields.isNotEmpty) {
      await _showMissingFieldsAlert(missingFields);
      return;
    }

    // ----------------------------------------------------------
    // 2. PARSE VALUES
    // ----------------------------------------------------------
    final c = double.tryParse(cgpa.text.trim());
    final t10 = double.tryParse(tenth.text.trim());
    final t12 = double.tryParse(twelfth.text.trim());
    final b = int.tryParse(backlogs.text.trim());

    // ----------------------------------------------------------
    // 3. CHECK INVALID VALUES
    // These are shown in RED so the student knows the value is
    // wrong rather than simply missing.
    // ----------------------------------------------------------
    if (c == null) {
      await _showInvalidValueAlert(
        'CGPA must be a valid number between 0 and 10.\n\nExample: 8.5',
      );
      return;
    }

    if (c < 0 || c > 10) {
      await _showInvalidValueAlert(
        'Invalid CGPA: ${cgpa.text.trim()}\n\nCGPA must be between 0 and 10.',
      );
      return;
    }

    if (t10 == null) {
      await _showInvalidValueAlert(
        '10th Percentage must be a valid number between 0 and 100.',
      );
      return;
    }

    if (t10 < 0 || t10 > 100) {
      await _showInvalidValueAlert(
        'Invalid 10th Percentage: ${tenth.text.trim()}\n\nIt must be between 0 and 100.',
      );
      return;
    }

    if (t12 == null) {
      await _showInvalidValueAlert(
        '12th Percentage must be a valid number between 0 and 100.',
      );
      return;
    }

    if (t12 < 0 || t12 > 100) {
      await _showInvalidValueAlert(
        'Invalid 12th Percentage: ${twelfth.text.trim()}\n\nIt must be between 0 and 100.',
      );
      return;
    }

    if (b == null) {
      await _showInvalidValueAlert(
        'Number of Backlogs must be a whole number.\n\nExample: 0, 1 or 2.',
      );
      return;
    }

    if (b < 0) {
      await _showInvalidValueAlert(
        'Invalid Number of Backlogs: ${backlogs.text.trim()}\n\nBacklogs cannot be negative.',
      );
      return;
    }

    // ----------------------------------------------------------
    // 4. SAVE VALID DATA
    // ----------------------------------------------------------
    widget.student.name = name.text.trim();
    widget.student.cgpa = cgpa.text.trim();
    widget.student.tenth = tenth.text.trim();
    widget.student.twelfth = twelfth.text.trim();
    widget.student.backlogs = backlogs.text.trim();

    widget.onChanged();

    await _showNormalMessage(
      'Profile Saved',
      'Your profile details have been saved successfully.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
              title: 'Basic Information',
            ),

            const SizedBox(height: 12),

            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: branches.contains(
                      widget.student.branch)
                  ? widget.student.branch
                  : branches.first,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Engineering Branch',
                prefixIcon: Icon(Icons.school),
              ),
              items: branches
                  .map(
                    (branch) =>
                        DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  widget.student.branch = value;
                });

                widget.onChanged();
              },
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Academic Performance',
            ),

            const SizedBox(height: 12),

            TextField(
              controller: cgpa,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'CGPA (0 - 10)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: tenth,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText:
                    '10th Percentage (0 - 100)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: twelfth,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText:
                    '12th Percentage (0 - 100)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: backlogs,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Backlogs',
              ),
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Communication Confidence',
            ),

            const SizedBox(height: 8),

            const Text(
              'This is a self-reported confidence level. '
              'It is independent of your academic and assessment marks.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Interview & Communication Confidence',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${communicationConfidence.round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Slider(
              value: communicationConfidence,
              min: 0,
              max: 100,
              divisions: 20,
              label: '${communicationConfidence.round()}%',
              onChanged: (value) {
                setState(() {
                  communicationConfidence = value;
                });

                widget.onCommunicationChanged(
                  value.round(),
                );

                widget.onChanged();
              },
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Industry Exposure',
            ),

            const SizedBox(height: 12),

            Text(
              'Internship / Industrial Training: '
              '${widget.student.internshipMonths} months',
            ),

            Slider(
              value:
                  widget.student.internshipMonths.toDouble(),
              min: 0,
              max: 12,
              divisions: 12,
              label:
                  '${widget.student.internshipMonths} months',
              onChanged: (value) {
                setState(() {
                  widget.student.internshipMonths =
                      value.round();
                });

                widget.onChanged();
              },
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save),
                label: const Text('Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SKILLS PAGE
// ============================================================

class SkillsPage extends StatefulWidget {
  final StudentProfile student;
  final Map<String, int> skillLevels;
  final bool codingRelevant;
  final String primaryLanguage;
  final ValueChanged<String> onLanguageChanged;
  final VoidCallback onChanged;

  const SkillsPage({
    super.key,
    required this.student,
    required this.skillLevels,
    required this.codingRelevant,
    required this.primaryLanguage,
    required this.onLanguageChanged,
    required this.onChanged,
  });

  @override
  State<SkillsPage> createState() =>
      _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    final skills =
        branchSkills[widget.student.branch] ??
            const <String>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              widget.codingRelevant
                  ? 'Technical & Coding Skills'
                  : 'Branch & Industry Skills',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your skill categories change automatically with your branch.',
            ),

            const SizedBox(height: 20),

            if (widget.codingRelevant) ...[
              DropdownButtonFormField<String>(
                value: widget.primaryLanguage,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText:
                      'Primary Programming Language',
                  prefixIcon: Icon(Icons.code),
                ),
                items: const [
                  'Java',
                  'Python',
                  'C',
                  'C++',
                  'JavaScript',
                  'Dart',
                ]
                    .map(
                      (language) =>
                          DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    widget.onLanguageChanged(value);
                  }
                },
              ),

              const SizedBox(height: 20),
            ],

            ...skills.map(
              (skill) => _SkillRatingCard(
                skill: skill,
                level:
                    widget.skillLevels[skill] ?? 0,
                onChanged: (value) {
                  setState(() {
                    widget.skillLevels[skill] =
                        value;
                  });

                  widget.onChanged();
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Text(
                  widget.codingRelevant
                      ? 'Coding and DSA are included because software-oriented roles commonly assess programming and problem solving. They are only one part of your profile.'
                      : 'Coding and DSA are not used as the central skill category for this branch. The app emphasizes your actual core engineering tools, domain skills, projects and practical exposure.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ASSESSMENT PAGE
// ============================================================

class AssessmentPage extends StatefulWidget {
  final String branch;
  final int score;
  final bool taken;
  final ValueChanged<int> onCompleted;

  const AssessmentPage({
    super.key,
    required this.branch,
    required this.score,
    required this.taken,
    required this.onCompleted,
  });

  @override
  State<AssessmentPage> createState() =>
      _AssessmentPageState();
}

class _AssessmentPageState
    extends State<AssessmentPage> {
  int current = 0;

  final List<int> answers = [];

  @override
  void didUpdateWidget(
    covariant AssessmentPage oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.branch != widget.branch) {
      current = 0;
      answers.clear();
    }
  }

  void choose(
    int index,
    int option,
  ) {
    if (answers.length <= index) {
      answers.add(option);
    } else {
      answers[index] = option;
    }

    final questions =
        branchQuestions[widget.branch] ??
            const <Question>[];

    if (index < questions.length - 1) {
      setState(() {
        current++;
      });
    } else {
      final correct = List.generate(
        questions.length,
        (i) =>
            answers[i] == questions[i].answer
                ? 1
                : 0,
      ).fold<int>(
        0,
        (a, b) => a + b,
      );

      final percentage =
          ((correct / questions.length) * 100)
              .round();

      widget.onCompleted(percentage);

      setState(() {
        current = 0;
        answers.clear();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Assessment completed: $percentage%',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions =
        branchQuestions[widget.branch] ??
            const <Question>[];

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Assessment unavailable',
          ),
        ),
      );
    }

    final safeIndex =
        current.clamp(0, questions.length - 1);

    final question = questions[safeIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Assessment'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              'Technical Readiness Assessment',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            Text(
              '${widget.branch} • ${questions.length} questions',
            ),

            const SizedBox(height: 20),

            if (widget.taken)
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.check_circle,
                  ),
                  title: Text(
                    'Latest score: ${widget.score}%',
                  ),
                  subtitle: const Text(
                    'You can retake the assessment anytime.',
                  ),
                ),
              ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value:
                  (current + 1) /
                  questions.length,
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Question ${current + 1} of ${questions.length}',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      question.question,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),

                    const SizedBox(height: 18),

                    // IMPORTANT:
                    // Correctly closed List.generate.
                    ...List.generate(
                      question.options.length,
                      (i) => Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              choose(
                                current,
                                i,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                question.options[i],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'This assessment measures branch-specific technical readiness. It is not a guarantee of placement.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROJECTS PAGE
// ============================================================

class ProjectsPage extends StatefulWidget {
  final StudentProfile student;
  final List<ProjectData> projects;
  final VoidCallback onChanged;

  const ProjectsPage({
    super.key,
    required this.student,
    required this.projects,
    required this.onChanged,
  });

  @override
  State<ProjectsPage> createState() =>
      _ProjectsPageState();
}

class _ProjectsPageState
    extends State<ProjectsPage> {
  String? domain;

  String status = 'Completed';

  int impact = 3;

  final technologies =
      TextEditingController();

  final description =
      TextEditingController();

  @override
  void dispose() {
    technologies.dispose();
    description.dispose();

    super.dispose();
  }

  Future<void> addProject() async {
    final missingFields = <String>[];

    if (domain == null) {
      missingFields.add('Project Domain');
    }
    if (technologies.text.trim().isEmpty) {
      missingFields.add('Technologies / Tools Used');
    }
    if (description.text.trim().isEmpty) {
      missingFields.add('What real-world problem does it solve?');
    }

    if (missingFields.isNotEmpty) {
      await _showMissingProjectFieldsAlert(missingFields);
      return;
    }

    widget.projects.add(
      ProjectData(
        domain: domain!,
        status: status,
        technologies:
            technologies.text.trim(),
        description:
            description.text.trim(),
        impact: impact,
      ),
    );

    technologies.clear();
    description.clear();

    setState(() {
      domain = null;
      status = 'Completed';
      impact = 3;
    });

    widget.onChanged();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Project added successfully',
        ),
      ),
    );
  }

  Future<void> _showMissingProjectFieldsAlert(List<String> fields) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.info_outline),
          title: const Text(
            'Required Fields Missing',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Please fill all the required project fields before adding the project.\n\n${fields.map((field) => '• $field').join('\n')}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // toSet().toList() prevents duplicate
    // DropdownButton values.
    final domains =
        (projectDomains[widget.student.branch] ??
                const <String>[])
            .toSet()
            .toList();

    // If branch changes and the previous
    // domain no longer exists, reset it.
    if (domain != null &&
        !domains.contains(domain)) {
      domain = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projects & Portfolio',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              'Build Your Project Portfolio',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            Text(
              'The project domain changes automatically with ${widget.student.branch}.',
            ),

            const SizedBox(height: 20),

            const _SectionTitle(
              title: 'Project Information',
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: domain,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Project Domain',
                prefixIcon:
                    Icon(Icons.category),
              ),
              items: domains
                  .map(
                    (item) =>
                        DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  domain = value;
                });
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: 'Project Status',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Completed',
                  child: Text('Completed'),
                ),
                DropdownMenuItem(
                  value: 'In Progress',
                  child: Text('In Progress'),
                ),
                DropdownMenuItem(
                  value: 'Prototype',
                  child: Text('Prototype'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    status = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: technologies,
              decoration: const InputDecoration(
                labelText:
                    'Technologies / Tools Used',
                hintText:
                    'Example: AutoCAD, STAAD.Pro, Python, Flutter',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: description,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText:
                    'What real-world problem does it solve?',
                hintText:
                    'Explain the practical problem, users or industry use case.',
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Practical Impact: $impact / 5',
            ),

            Slider(
              value: impact.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: '$impact / 5',
              onChanged: (value) {
                setState(() {
                  impact = value.round();
                });
              },
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: addProject,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Project',
                ),
              ),
            ),

            const SizedBox(height: 28),

            const _SectionTitle(
              title: 'Your Projects',
            ),

            const SizedBox(height: 12),

            if (widget.projects.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'No projects added yet.',
                    ),
                  ),
                ),
              ),

            ...widget.projects
                .asMap()
                .entries
                .map(
                  (entry) {
                    final project = entry.value;

                    return Card(
                      child: ListTile(
                        leading:
                            const CircleAvatar(
                          child: Icon(
                            Icons.folder,
                          ),
                        ),
                        title: Text(
                          project.domain,
                        ),
                        subtitle: Text(
                          '${project.status}\n'
                          '${project.technologies}\n'
                          'Impact: ${project.impact}/5\n'
                          '${project.description}',
                        ),
                        isThreeLine: false,
                        trailing:
                            IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.projects
                                  .removeAt(
                                entry.key,
                              );
                            });

                            widget.onChanged();
                          },
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ROADMAP PAGE
// ============================================================

class RoadmapPage extends StatelessWidget {
  final StudentProfile student;
  final Map<String, int> skillLevels;
  final List<ProjectData> projects;
  final int assessmentScore;
  final bool assessmentTaken;
  final bool codingRelevant;

  const RoadmapPage({
    super.key,
    required this.student,
    required this.skillLevels,
    required this.projects,
    required this.assessmentScore,
    required this.assessmentTaken,
    required this.codingRelevant,
  });

  @override
  Widget build(BuildContext context) {
    final skills =
        branchSkills[student.branch] ??
            const <String>[];

    final strongSkills = skills
        .where(
          (skill) =>
              (skillLevels[skill] ?? 0) >= 3,
        )
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Placement Roadmap',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              'Your Personalized Roadmap',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            const Text(
              'This plan is generated from your branch, skills, assessment, projects and industry exposure.',
            ),

            const SizedBox(height: 20),

            _RoadmapStep(
              number: 1,
              title: 'Academic Foundation',
              description:
                  'Maintain your CGPA and clear backlogs because eligibility criteria can depend on academics.',
              completed:
                  (double.tryParse(
                            student.cgpa,
                          ) ??
                          0) >=
                      7 &&
                  (int.tryParse(
                            student.backlogs,
                          ) ??
                          0) ==
                      0,
            ),

            _RoadmapStep(
              number: 2,
              title: codingRelevant
                  ? 'Coding & Problem Solving'
                  : 'Core Technical Foundation',
              description: codingRelevant
                  ? 'Strengthen programming, DSA and problem solving for software-oriented roles.'
                  : 'Strengthen the actual core subjects, engineering tools and domain knowledge expected in your branch.',
              completed: skills.isNotEmpty &&
                  strongSkills >=
                      (skills.length / 2)
                          .ceil(),
            ),

            _RoadmapStep(
              number: 3,
              title: 'Practical Projects',
              description:
                  'Build projects that demonstrate how you solve real problems, not just tutorial completion.',
              completed:
                  projects.isNotEmpty,
            ),

            _RoadmapStep(
              number: 4,
              title: 'Industry Exposure',
              description:
                  'Add internships, industrial training, research, field work or relevant practical exposure.',
              completed:
                  student.internshipMonths >
                      0,
            ),

            _RoadmapStep(
              number: 5,
              title: 'Branch Assessment',
              description:
                  'Use the built-in assessment to measure technical readiness and identify weak areas.',
              completed:
                  assessmentTaken &&
                  assessmentScore >= 60,
            ),

            _RoadmapStep(
              number: 6,
              title: 'Target Roles',
              description:
                  'Use your strongest skills and project domains to focus applications on suitable roles.',
              completed: false,
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Text(
                  codingRelevant
                      ? 'Your pathway: combine coding ability with projects, internships, communication and branch fundamentals. Do not depend on one coding-platform score.'
                      : 'Your pathway: prioritize core engineering knowledge, industry tools, practical projects, internships, aptitude, communication and interview preparation. Coding remains an optional supporting skill unless a target role requires it.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COMMON WIDGETS
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

// ============================================================
// SCORE CARD
// ============================================================

class _ScoreCard extends StatelessWidget {
  final double score;
  final String readiness;

  const _ScoreCard({
    required this.score,
    required this.readiness,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            SizedBox(
              width: 110,
              height: 110,

              child: Stack(
                alignment: Alignment.center,

                children: [
                  CircularProgressIndicator(
                    value:
                        (score / 100).clamp(0.0, 1.0).toDouble(),
                    strokeWidth: 10,
                  ),

                  Text(
                    '${score.round()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Placement Readiness',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    readiness,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'A readiness indicator, not a guarantee of placement.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SCORE BREAKDOWN
// ============================================================

class _BreakdownRow extends StatelessWidget {
  final String label;
  final double value;
  final double max;

  const _BreakdownRow(
    this.label,
    this.value,
    this.max,
  );

  @override
  Widget build(BuildContext context) {
    final progress = max == 0
        ? 0.0
        : (value / max).clamp(0.0, 1.0).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label),
              ),

              Text(
                '${value.toStringAsFixed(1)} / ${max.toStringAsFixed(0)}',
              ),
            ],
          ),

          const SizedBox(height: 4),

          LinearProgressIndicator(
            value: progress,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(14),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              Icon(icon),

              const SizedBox(height: 8),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SKILL RATING CARD
// ============================================================

class _SkillRatingCard
    extends StatelessWidget {
  final String skill;
  final int level;
  final ValueChanged<int> onChanged;

  const _SkillRatingCard({
    required this.skill,
    required this.level,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    skill,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

                Text(
                  level == 0
                      ? 'Not Rated'
                      : '$level / 5',
                ),
              ],
            ),

            Slider(
              value: level.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: '$level / 5',
              onChanged: (value) {
                onChanged(
                  value.round(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ROADMAP STEP
// ============================================================

class _RoadmapStep
    extends StatelessWidget {
  final int number;
  final String title;
  final String description;
  final bool completed;

  const _RoadmapStep({
    required this.number,
    required this.title,
    required this.description,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: completed
              ? const Icon(Icons.check)
              : Text('$number'),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 6),

          child: Text(description),
        ),
      ),
    );
  }
}


// ============================================================
// FIREBASE AUTHENTICATION
// ============================================================

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          return const PlacementHome();
        }

        return const AuthPage();
      },
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool isRegister = false;
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill all required fields.');
      return;
    }

    if (isRegister && name.isEmpty) {
      _showMessage('Please enter your name.');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password must contain at least 6 characters.');
      return;
    }

    setState(() => isLoading = true);

    try {
      if (isRegister) {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await credential.user?.updateDisplayName(name);

        final user = credential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'branch': branches.first,
            'cgpa': '',
            'tenth': '',
            'twelfth': '',
            'backlogs': '0',
            'internshipMonths': 0,
            'communicationScore': 0,
            'primaryLanguage': 'Java',
            'assessmentScore': 0,
            'assessmentTaken': false,
            'skillLevels': <String, int>{},
            'projects': <Map<String, dynamic>>[],
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication failed.';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;
        case 'user-not-found':
          message = 'No account found with this email.';
          break;
        case 'wrong-password':
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        case 'network-request-failed':
          message = 'Network error. Check your internet connection.';
          break;
        default:
          if (e.message != null && e.message!.isNotEmpty) {
            message = e.message!;
          }
      }

      _showMessage(message);
    } catch (e) {
      _showMessage('Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Enter your email first to reset your password.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      _showMessage('Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? 'Could not send password reset email.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.school,
                      size: 72,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isRegister
                          ? 'Create your account'
                          : 'Welcome back',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isRegister
                          ? 'Create your Placement360 student account'
                          : 'Login to continue to Placement360',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    if (isRegister) ...[
                      TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    if (!isRegister) ...[
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: isLoading ? null : _resetPassword,
                          child: const Text('Forgot password?'),
                        ),
                      ),
                    ] else
                      const SizedBox(height: 12),
                    SizedBox(
                      height: 52,
                      child: FilledButton(
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                isRegister
                                    ? 'Create Account'
                                    : 'Login',
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              setState(() {
                                isRegister = !isRegister;
                              });
                            },
                      child: Text(
                        isRegister
                            ? 'Already have an account? Login'
                            : 'New student? Create an account',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
