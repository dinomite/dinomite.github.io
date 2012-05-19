--- 
layout: post
comments: true
title: MD5 Digests in Java
mt_id: 102
date: 2007-03-22 13:59:16 -07:00
---
File hashes have a multitude of uses and MD5 is, despite the fact that weaknesses have been found in the algorithm, still very useful and widely employed.  Creating MD5 digests in Java is quite easy, but the documentation for [MessageDigest](http://java.sun.com/j2se/1.4.2/docs/api/java/security/MessageDigest.html) is a little bit tricky.  Here is a simple method that takes in a string of input and returns the hash of the string.

<code><pre>
public static String md5(String input) {
	// Compute the MD5 digest of the passed String
	MessageDigest algorithm = null;
	try {
		algorithm = MessageDigest.getInstance("MD5");
	} catch (NoSuchAlgorithmException e) { e.printStackTrace(); }
	algorithm.reset();
	byte[] hash = algorithm.digest(input.getBytes());

	// Convert it to a String
	StringBuffer ret = new StringBuffer();
	for (int x = 0; x < hash.length; x++) {
		String hexString = Integer.toHexString(0xFF & hash[x]);
		if (hexString.length() == 1)
			hexString = "0" + hexString;

		ret.append(hexString);

		// Add the dashes
		if (x == 3 || x == 5 || x == 7 || x == 9)
			ret.append("-");
	} //for

	return ret.toString().toUpperCase();
} //md5
</code></pre>
