//
// This is only a SKELETON file for the 'Reverse String' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const reverseString = (x) => {
  if (x == "") {
    return "";
  } else {
    return x.charAt(x.length - 1) + reverseString(x.slice(0, x.length - 1));
  }
};
