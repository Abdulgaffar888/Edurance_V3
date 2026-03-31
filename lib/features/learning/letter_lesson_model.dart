// ─────────────────────────────────────────────
//  DATA MODEL  –  No widgets, no Flutter imports
// ─────────────────────────────────────────────

class LetterLesson {
  /// The uppercase letter being taught, e.g. "A"
  final String letter;

  /// A fun emoji that matches the word, e.g. "🍎"
  final String emoji;

  /// The example word, e.g. "Apple"
  final String word;

  /// How the letter sounds/is pronounced, e.g. "Ay"
  final String pronunciation;

  /// The MCQ question shown to the child
  final String mcqQuestion;

  /// Exactly 3 answer choices
  final List<String> options;

  /// Index into [options] that is correct (0, 1, or 2)
  final int correctIndex;

  /// Encouraging hint shown when the child picks a wrong answer
  final String altExplanation;

  const LetterLesson({
    required this.letter,
    required this.emoji,
    required this.word,
    required this.pronunciation,
    required this.mcqQuestion,
    required this.options,
    required this.correctIndex,
    required this.altExplanation,
  });
}

// ─────────────────────────────────────────────
//  ALL 26 LETTER LESSONS  (A – Z)
// ─────────────────────────────────────────────
const List<LetterLesson> kLetterLessons = [
  // ── A ──────────────────────────────────────
  LetterLesson(
    letter: 'A',
    emoji: '🍎',
    word: 'Apple',
    pronunciation: 'Ay',
    mcqQuestion: 'Which word starts with the letter A?',
    options: ['Orange', 'Apple', 'Banana'],
    correctIndex: 1,
    altExplanation: 'Oops! 🍎 Apple starts with A. A says "Ay" — like Ay-pple!',
  ),

  // ── B ──────────────────────────────────────
  LetterLesson(
    letter: 'B',
    emoji: '🏏',
    word: 'Ball',
    pronunciation: 'Buh',
    mcqQuestion: 'Which word begins with B?',
    options: ['Ball', 'Kite', 'Doll'],
    correctIndex: 0,
    altExplanation: 'Almost! 🏏 Ball starts with B. B says "Buh" — Buh-all!',
  ),

  // ── C ──────────────────────────────────────
  LetterLesson(
    letter: 'C',
    emoji: '🐱',
    word: 'Cat',
    pronunciation: 'Kuh',
    mcqQuestion: 'Which word starts with C?',
    options: ['Dog', 'Fish', 'Cat'],
    correctIndex: 2,
    altExplanation: 'So close! 🐱 Cat starts with C. C says "Kuh" — Kuh-at!',
  ),

  // ── D ──────────────────────────────────────
  LetterLesson(
    letter: 'D',
    emoji: '🐕',
    word: 'Dog',
    pronunciation: 'Duh',
    mcqQuestion: 'Which animal\'s name starts with D?',
    options: ['Cat', 'Dog', 'Cow'],
    correctIndex: 1,
    altExplanation: 'Good try! 🐕 Dog starts with D. D says "Duh" — Duh-og!',
  ),

  // ── E ──────────────────────────────────────
  LetterLesson(
    letter: 'E',
    emoji: '🐘',
    word: 'Elephant',
    pronunciation: 'Eh',
    mcqQuestion: 'Which word starts with the letter E?',
    options: ['Elephant', 'Tiger', 'Lion'],
    correctIndex: 0,
    altExplanation: 'Nice try! 🐘 Elephant starts with E. E says "Eh" — Eh-lephant!',
  ),

  // ── F ──────────────────────────────────────
  LetterLesson(
    letter: 'F',
    emoji: '🐟',
    word: 'Fish',
    pronunciation: 'Fuh',
    mcqQuestion: 'Which word begins with F?',
    options: ['Bird', 'Fish', 'Frog'],
    correctIndex: 1,
    altExplanation: 'Almost! 🐟 Fish starts with F. F says "Fuh" — Fuh-ish!',
  ),

  // ── G ──────────────────────────────────────
  LetterLesson(
    letter: 'G',
    emoji: '🍇',
    word: 'Grapes',
    pronunciation: 'Guh',
    mcqQuestion: 'Which fruit starts with G?',
    options: ['Mango', 'Guava', 'Grapes'],
    correctIndex: 2,
    altExplanation: 'Good effort! 🍇 Grapes starts with G. G says "Guh" — Guh-rapes!',
  ),

  // ── H ──────────────────────────────────────
  LetterLesson(
    letter: 'H',
    emoji: '🏠',
    word: 'House',
    pronunciation: 'Huh',
    mcqQuestion: 'Which word starts with H?',
    options: ['House', 'Room', 'Door'],
    correctIndex: 0,
    altExplanation: 'So close! 🏠 House starts with H. H says "Huh" — Huh-ouse!',
  ),

  // ── I ──────────────────────────────────────
  LetterLesson(
    letter: 'I',
    emoji: '🍦',
    word: 'Ice Cream',
    pronunciation: 'Eye',
    mcqQuestion: 'Which word starts with I?',
    options: ['Cake', 'Ice Cream', 'Candy'],
    correctIndex: 1,
    altExplanation: 'Great try! 🍦 Ice Cream starts with I. I says "Eye" — I-ce cream!',
  ),

  // ── J ──────────────────────────────────────
  LetterLesson(
    letter: 'J',
    emoji: '🍊',
    word: 'Juice',
    pronunciation: 'Juh',
    mcqQuestion: 'Which word begins with J?',
    options: ['Water', 'Milk', 'Juice'],
    correctIndex: 2,
    altExplanation: 'Nice try! 🍊 Juice starts with J. J says "Juh" — Juh-uice!',
  ),

  // ── K ──────────────────────────────────────
  LetterLesson(
    letter: 'K',
    emoji: '🪁',
    word: 'Kite',
    pronunciation: 'Kuh',
    mcqQuestion: 'Which toy starts with K?',
    options: ['Kite', 'Ball', 'Doll'],
    correctIndex: 0,
    altExplanation: 'Almost there! 🪁 Kite starts with K. K says "Kuh" — Kuh-ite!',
  ),

  // ── L ──────────────────────────────────────
  LetterLesson(
    letter: 'L',
    emoji: '🦁',
    word: 'Lion',
    pronunciation: 'Luh',
    mcqQuestion: 'Which animal starts with L?',
    options: ['Tiger', 'Lion', 'Bear'],
    correctIndex: 1,
    altExplanation: 'Good try! 🦁 Lion starts with L. L says "Luh" — Luh-ion!',
  ),

  // ── M ──────────────────────────────────────
  LetterLesson(
    letter: 'M',
    emoji: '🥭',
    word: 'Mango',
    pronunciation: 'Muh',
    mcqQuestion: 'Which fruit starts with M?',
    options: ['Apple', 'Banana', 'Mango'],
    correctIndex: 2,
    altExplanation: 'So close! 🥭 Mango starts with M. M says "Muh" — Muh-ango!',
  ),

  // ── N ──────────────────────────────────────
  LetterLesson(
    letter: 'N',
    emoji: '📓',
    word: 'Notebook',
    pronunciation: 'Nuh',
    mcqQuestion: 'Which school thing starts with N?',
    options: ['Notebook', 'Pencil', 'Eraser'],
    correctIndex: 0,
    altExplanation: 'Nice try! 📓 Notebook starts with N. N says "Nuh" — Nuh-otebook!',
  ),

  // ── O ──────────────────────────────────────
  LetterLesson(
    letter: 'O',
    emoji: '🍊',
    word: 'Orange',
    pronunciation: 'Oh',
    mcqQuestion: 'Which fruit starts with O?',
    options: ['Guava', 'Orange', 'Lemon'],
    correctIndex: 1,
    altExplanation: 'Almost! 🍊 Orange starts with O. O says "Oh" — Oh-range!',
  ),

  // ── P ──────────────────────────────────────
  LetterLesson(
    letter: 'P',
    emoji: '🥜',
    word: 'Peanut',
    pronunciation: 'Puh',
    mcqQuestion: 'Which snack starts with P?',
    options: ['Biscuit', 'Chips', 'Peanut'],
    correctIndex: 2,
    altExplanation: 'Great effort! 🥜 Peanut starts with P. P says "Puh" — Puh-eanut!',
  ),

  // ── Q ──────────────────────────────────────
  LetterLesson(
    letter: 'Q',
    emoji: '👑',
    word: 'Queen',
    pronunciation: 'Kwuh',
    mcqQuestion: 'Which word starts with Q?',
    options: ['Queen', 'King', 'Prince'],
    correctIndex: 0,
    altExplanation: 'Good try! 👑 Queen starts with Q. Q says "Kwuh" — Kwuh-een!',
  ),

  // ── R ──────────────────────────────────────
  LetterLesson(
    letter: 'R',
    emoji: '🌹',
    word: 'Rose',
    pronunciation: 'Ruh',
    mcqQuestion: 'Which flower starts with R?',
    options: ['Lotus', 'Rose', 'Lily'],
    correctIndex: 1,
    altExplanation: 'So close! 🌹 Rose starts with R. R says "Ruh" — Ruh-ose!',
  ),

  // ── S ──────────────────────────────────────
  LetterLesson(
    letter: 'S',
    emoji: '☀️',
    word: 'Sun',
    pronunciation: 'Suh',
    mcqQuestion: 'Which word starts with S?',
    options: ['Moon', 'Star', 'Sun'],
    correctIndex: 2,
    altExplanation: 'Almost! ☀️ Sun starts with S. S says "Suh" — Suh-un!',
  ),

  // ── T ──────────────────────────────────────
  LetterLesson(
    letter: 'T',
    emoji: '🐯',
    word: 'Tiger',
    pronunciation: 'Tuh',
    mcqQuestion: 'Which animal starts with T?',
    options: ['Tiger', 'Lion', 'Bear'],
    correctIndex: 0,
    altExplanation: 'Good effort! 🐯 Tiger starts with T. T says "Tuh" — Tuh-iger!',
  ),

  // ── U ──────────────────────────────────────
  LetterLesson(
    letter: 'U',
    emoji: '☂️',
    word: 'Umbrella',
    pronunciation: 'Uh',
    mcqQuestion: 'Which thing starts with U?',
    options: ['Raincoat', 'Umbrella', 'Hat'],
    correctIndex: 1,
    altExplanation: 'Nice try! ☂️ Umbrella starts with U. U says "Uh" — Uh-mbrella!',
  ),

  // ── V ──────────────────────────────────────
  LetterLesson(
    letter: 'V',
    emoji: '🎻',
    word: 'Violin',
    pronunciation: 'Vuh',
    mcqQuestion: 'Which instrument starts with V?',
    options: ['Drum', 'Flute', 'Violin'],
    correctIndex: 2,
    altExplanation: 'Almost there! 🎻 Violin starts with V. V says "Vuh" — Vuh-iolin!',
  ),

  // ── W ──────────────────────────────────────
  LetterLesson(
    letter: 'W',
    emoji: '🌊',
    word: 'Water',
    pronunciation: 'Wuh',
    mcqQuestion: 'Which word starts with W?',
    options: ['Water', 'Juice', 'Milk'],
    correctIndex: 0,
    altExplanation: 'Good try! 🌊 Water starts with W. W says "Wuh" — Wuh-ater!',
  ),

  // ── X ──────────────────────────────────────
  LetterLesson(
    letter: 'X',
    emoji: '🎸',
    word: 'Xylophone',
    pronunciation: 'Zuh',
    mcqQuestion: 'Which instrument starts with X?',
    options: ['Guitar', 'Xylophone', 'Drum'],
    correctIndex: 1,
    altExplanation:
        'So close! 🎸 Xylophone starts with X. X says "Zuh" — Zuh-ylophone! It\'s a tricky one!',
  ),

  // ── Y ──────────────────────────────────────
  LetterLesson(
    letter: 'Y',
    emoji: '🧶',
    word: 'Yarn',
    pronunciation: 'Yuh',
    mcqQuestion: 'Which word starts with Y?',
    options: ['Thread', 'Rope', 'Yarn'],
    correctIndex: 2,
    altExplanation: 'Almost! 🧶 Yarn starts with Y. Y says "Yuh" — Yuh-arn!',
  ),

  // ── Z ──────────────────────────────────────
  LetterLesson(
    letter: 'Z',
    emoji: '🦓',
    word: 'Zebra',
    pronunciation: 'Zuh',
    mcqQuestion: 'Which animal starts with Z?',
    options: ['Zebra', 'Giraffe', 'Hippo'],
    correctIndex: 0,
    altExplanation:
        'Great try! 🦓 Zebra starts with Z. Z says "Zuh" — Zuh-ebra! You\'re almost a star!',
  ),
];
