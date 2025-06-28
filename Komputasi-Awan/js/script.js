
document.getElementById('questionForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const data = {
      question: document.getElementById('question').value,
      optionA: document.getElementById('optionA').value,
      optionB: document.getElementById('optionB').value,
      optionC: document.getElementById('optionC').value,
      optionD: document.getElementById('optionD').value,
      correctAnswer: document.getElementById('correctAnswer').value.toUpperCase(),
      score: parseInt(document.getElementById('score').value)
    };
    console.log('Soal disimpan:', data);
    alert("Soal berhasil disimpan!");
    this.reset(); // kosongkan form
});

document.getElementById('questionForm').addEventListener('submit', function(e) {
    e.preventDefault();
    alert("Soal berhasil disimpan!");
    this.reset();
});