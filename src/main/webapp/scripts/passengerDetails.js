function addPassengerFields() {
    var numPassengers = document.getElementById("numPassengers").value;
    var container = document.getElementById("passengerContainer");
    container.innerHTML = ""; // Clear previous inputs

    for (var i = 1; i <= numPassengers; i++) {
        var div = document.createElement("div");
        div.classList.add("passenger-container");

        div.innerHTML = `
                    <h3>Passenger ${i}</h3>
                    <label for="fullname${i}">Full Name:</label>
                    <input type="text" id="fullname${i}" name="fullname${i}" required>

                    <label for="dob${i}">Date of Birth:</label>
                    <input type="date" id="dob${i}" name="dob${i}" required>

                    <label for="gender${i}">Gender:</label>
                    <select id="gender${i}" name="gender${i}" required>
                        <option value="">Select Gender</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>

                    <label for="passport${i}">Passport Number:</label>
                    <input type="text" id="passport${i}" name="passport${i}" required>
                `;
        container.appendChild(div);
    }
}