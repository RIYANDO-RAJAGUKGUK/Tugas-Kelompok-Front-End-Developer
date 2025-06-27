document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("review-form");
  const reviewList = document.getElementById("review-list");

  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const name = document.getElementById("reviewer-name").value.trim();
    const text = document.getElementById("review-text").value.trim();

    if (name && text) {
      const li = document.createElement("li");
      li.innerHTML = `⭐️⭐️⭐️⭐️⭐️ - "<strong>${name}</strong>: ${text}"`;
      reviewList.appendChild(li);

      form.reset();
    }
  });
});
