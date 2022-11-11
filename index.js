// program to find the factors of an integer

// take input
// eslint-disable-next-line no-alert
const num = prompt("Enter a positive number: ");

// eslint-disable-next-line no-console
console.log(`The factors of ${num} is:`);

// looping through 1 to num
for (let i = 1; i <= num; i++) {
	// check if number is a factor
	if (num % i === 0) {
		// eslint-disable-next-line no-console
		console.log(i);
	}
}
