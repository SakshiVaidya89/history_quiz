class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String period;
  final String eraId;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.period,
    required this.eraId,
  });
}

class QuizData {
  static List<Question> questions = [
    // Ancient World Questions
    Question(
      questionText: 'Which ancient civilization built the Great Pyramid of Giza?',
      options: ['Mesopotamians', 'Egyptians', 'Greeks', 'Romans'],
      correctAnswerIndex: 1,
      explanation: 'The Great Pyramid of Giza was built by the ancient Egyptians during the Old Kingdom period, around 2560 BCE.',
      period: 'Ancient Egypt',
      eraId: 'ancient_world',
    ),
    Question(
      questionText: 'Who was the first Emperor of Rome?',
      options: ['Julius Caesar', 'Augustus', 'Nero', 'Constantine'],
      correctAnswerIndex: 1,
      explanation: 'Augustus (born Octavian) became the first Roman Emperor in 27 BCE after defeating Mark Antony and Cleopatra.',
      period: 'Ancient Rome',
      eraId: 'ancient_world',
    ),
    Question(
      questionText: 'Which civilization developed the first known writing system?',
      options: ['Egyptians', 'Sumerians', 'Chinese', 'Indus Valley'],
      correctAnswerIndex: 1,
      explanation: 'The Sumerians of Mesopotamia developed the first known writing system called cuneiform around 3400-3200 BCE.',
      period: 'Ancient Mesopotamia',
      eraId: 'ancient_world',
    ),
    
    // Medieval Period Questions
    Question(
      questionText: 'What was the name of the plague that devastated Europe in the 14th century?',
      options: ['The White Death', 'The Black Death', 'The Great Mortality', 'The Bubonic Plague'],
      correctAnswerIndex: 1,
      explanation: 'The Black Death, also known as the Great Mortality or the Bubonic Plague, killed an estimated 75-200 million people in Eurasia from 1347 to 1351.',
      period: 'Medieval Europe',
      eraId: 'medieval',
    ),
    Question(
      questionText: 'Which of these inventions came first?',
      options: ['Printing Press', 'Steam Engine', 'Telescope', 'Compass'],
      correctAnswerIndex: 3,
      explanation: 'The compass was invented in China during the Han Dynasty (2nd century BCE), long before the other inventions listed.',
      period: 'Medieval Technology',
      eraId: 'medieval',
    ),
    Question(
      questionText: 'Who was Genghis Khan?',
      options: ['A Chinese Emperor', 'A Japanese Shogun', 'The founder of the Mongol Empire', 'A Korean General'],
      correctAnswerIndex: 2,
      explanation: 'Genghis Khan was the founder and first Great Khan of the Mongol Empire, which became the largest contiguous empire in history after his death.',
      period: 'Medieval Asia',
      eraId: 'medieval',
    ),
    
    // Renaissance Questions
    Question(
      questionText: 'Who painted the Mona Lisa?',
      options: ['Michelangelo', 'Leonardo da Vinci', 'Raphael', 'Donatello'],
      correctAnswerIndex: 1,
      explanation: 'Leonardo da Vinci painted the Mona Lisa between 1503 and 1519. It is now displayed at the Louvre Museum in Paris.',
      period: 'Renaissance Art',
      eraId: 'renaissance',
    ),
    Question(
      questionText: 'Which scientist formulated the theory of heliocentrism, placing the Sun at the center of the solar system?',
      options: ['Galileo Galilei', 'Isaac Newton', 'Nicolaus Copernicus', 'Johannes Kepler'],
      correctAnswerIndex: 2,
      explanation: 'Nicolaus Copernicus formulated a model of the universe that placed the Sun rather than Earth at the center of the universe, published in his book "De revolutionibus orbium coelestium" in 1543.',
      period: 'Scientific Revolution',
      eraId: 'renaissance',
    ),
    Question(
      questionText: 'Which of these was NOT an important Renaissance humanist?',
      options: ['Erasmus', 'Petrarch', 'Machiavelli', 'Martin Luther'],
      correctAnswerIndex: 3,
      explanation: 'While Martin Luther was an important figure of the Reformation, he is not typically classified as a Renaissance humanist like the others listed.',
      period: 'Renaissance Philosophy',
      eraId: 'renaissance',
    ),
    
    // Modern History Questions
    Question(
      questionText: 'Which event marked the beginning of World War I?',
      options: [
        'The assassination of Archduke Franz Ferdinand',
        'The invasion of Poland',
        'The bombing of Pearl Harbor',
        'The Russian Revolution'
      ],
      correctAnswerIndex: 0,
      explanation: 'World War I began after the assassination of Archduke Franz Ferdinand of Austria in Sarajevo on June 28, 1914.',
      period: 'World War I',
      eraId: 'modern',
    ),
    Question(
      questionText: 'Who was the leader of the Soviet Union during most of World War II?',
      options: ['Vladimir Lenin', 'Leon Trotsky', 'Joseph Stalin', 'Nikita Khrushchev'],
      correctAnswerIndex: 2,
      explanation: 'Joseph Stalin was the leader of the Soviet Union from the mid-1920s until his death in 1953, including during World War II.',
      period: 'World War II',
      eraId: 'modern',
    ),
    Question(
      questionText: 'Which country was NOT part of the Allied Powers during World War II?',
      options: ['United States', 'Soviet Union', 'Italy', 'Great Britain'],
      correctAnswerIndex: 2,
      explanation: 'Italy was part of the Axis Powers along with Nazi Germany and Japan during World War II.',
      period: 'World War II',
      eraId: 'modern',
    ),
    
    // Contemporary History Questions
    Question(
      questionText: 'When did the Berlin Wall fall?',
      options: ['1985', '1989', '1991', '1993'],
      correctAnswerIndex: 1,
      explanation: 'The Berlin Wall fell on November 9, 1989, marking a pivotal moment in the end of the Cold War.',
      period: 'Cold War',
      eraId: 'contemporary',
    ),
    Question(
      questionText: 'Who was the first woman to become Prime Minister of a country?',
      options: ['Margaret Thatcher', 'Indira Gandhi', 'Golda Meir', 'Sirimavo Bandaranaike'],
      correctAnswerIndex: 3,
      explanation: 'Sirimavo Bandaranaike of Ceylon (now Sri Lanka) became the world\'s first female prime minister in 1960.',
      period: 'Post-Colonial Era',
      eraId: 'contemporary',
    ),
    Question(
      questionText: 'Which event is often cited as the beginning of the Arab Spring?',
      options: [
        'The invasion of Iraq',
        'The self-immolation of Mohamed Bouazizi in Tunisia',
        'The Egyptian Revolution',
        'The Syrian Civil War'
      ],
      correctAnswerIndex: 1,
      explanation: 'The Arab Spring began with the Tunisian Revolution, sparked by the self-immolation of Mohamed Bouazizi on December 17, 2010.',
      period: 'Modern Middle East',
      eraId: 'contemporary',
    ),
    
    // Indian History Questions
    Question(
      questionText: 'Which ancient Indian empire was founded by Chandragupta Maurya?',
      options: ['Gupta Empire', 'Maurya Empire', 'Chola Empire', 'Maratha Empire'],
      correctAnswerIndex: 1,
      explanation: 'Chandragupta Maurya founded the Maurya Empire in 322 BCE, which grew to be one of the largest empires of the Indian subcontinent.',
      period: 'Ancient India',
      eraId: 'indian',
    ),
    Question(
      questionText: 'Who was the Mughal emperor who built the Taj Mahal?',
      options: ['Akbar', 'Jahangir', 'Shah Jahan', 'Aurangzeb'],
      correctAnswerIndex: 2,
      explanation: 'Shah Jahan commissioned the building of the Taj Mahal in memory of his favorite wife, Mumtaz Mahal, who died in 1631.',
      period: 'Medieval India',
      eraId: 'indian',
    ),
    Question(
      questionText: 'Which Indian leader is known for his philosophy of non-violence (ahimsa) during the independence movement?',
      options: ['Jawaharlal Nehru', 'Subhas Chandra Bose', 'Mahatma Gandhi', 'Sardar Vallabhbhai Patel'],
      correctAnswerIndex: 2,
      explanation: 'Mahatma Gandhi led India to independence through non-violent civil disobedience, inspiring movements for civil rights and freedom across the world.',
      period: 'Indian Independence',
      eraId: 'indian',
    ),
    Question(
      questionText: 'The Indus Valley Civilization was centered around which modern-day countries?',
      options: ['India and Nepal', 'India and Pakistan', 'Pakistan and Afghanistan', 'India and Bangladesh'],
      correctAnswerIndex: 1,
      explanation: 'The Indus Valley Civilization (3300–1300 BCE) was primarily located in what is now Pakistan and northwest India.',
      period: 'Ancient India',
      eraId: 'indian',
    ),
    Question(
      questionText: 'Which battle in 1757 established British rule in Bengal?',
      options: ['Battle of Plassey', 'Battle of Buxar', 'Battle of Panipat', 'Battle of Haldighati'],
      correctAnswerIndex: 0,
      explanation: 'The Battle of Plassey was fought on June 23, 1757, and marked the beginning of British rule in India through the East India Company.',
      period: 'Colonial India',
      eraId: 'indian',
    ),
  ];

  static List<Question> getQuestionsByEra(String eraId) {
    return questions.where((question) => question.eraId == eraId).toList();
  }
}