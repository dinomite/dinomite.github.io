--- 
layout: post
comments: true
title: Voting Systems
mt_id: 227
date: 2008-11-03 23:50:50 -08:00
---
On the eve of the election, I am thinking about [voting systems](http://en.wikipedia.org/wiki/Voting_system) better than that which is currently employed in United States [general elections](http://en.wikipedia.org/wiki/General_election).

Among [single-winner voting systems](http://en.wikipedia.org/wiki/Single-winner_voting_system), the most common is [instant-runoff voting](http://en.wikipedia.org/wiki/Instant-runoff_voting) and the simplest, making it the most reasonable choice as a replacement for the single-vote system that we currently use.  In an instant-runoff election, you fill out a ballot showing the order of preference for the candidates available.  When votes are tallied, your number one candidate is used to tally votes; if that candidate did not achieve a majority, then he is eliminated from the election and your second choice is taken.  This continues until a candidate has achieved a majority, thereby winning the election.

IRV allows for voters to cast a ballot for a candidate whom they truly believe in without feeling that they are throwing their vote away.  This solves the Ralph Nader problem from the 2000 election.  Nader was the prime choice for many Americans but his status as a third-party candidate meant that he had no chance of winning the election.  Many who might have wanted to vote for Nader instead voted for one of the two major-party candidates, because their vote would otherwise be wasted.  The few who did vote for Nader, were then blamed for Al Gore's loss of the election, since they most likely would have voted for the Democratic candidate were it not for the Green Party's presence.  Instant-runoff voting keeps third-party candidates from "stealing" votes from the major parties and makes third-parties viable, since voters can feel confident in voting for such candidates.

Another area of voting that is lacking in the United States is the security and integrity of the voting system.  There are endless reports of electronic voting machines losing votes, miscounting votes or being tampered with.  Creating a system that is both secure and verifiable while at the same time anonymous is not a trivial task but there is a group of people who deal with such odd logic puzzles: cryptographers.  After the fiasco of electronic voting machines in the 2004 election, many people spent time thinking about methods for secure, verifiable voting.  One of those was [Ron Rivest](http://en.wikipedia.org/wiki/Ron_Rivest), the R in RSA, who came up with the [ThreeBallot](http://en.wikipedia.org/wiki/ThreeBallot) voting protocol.

The entire protocol is [detailed in Rivest's paper](http://theory.csail.mit.edu/~rivest/Rivest-TheThreeBallotVotingSystem.pdf), but the gist of the system is that the voter fills out three ballots which are identical, save for a unique number identifying each.  Through some cryptographic logic magic, the ballots are marked such that any single ballot of the triplet does not divulge whom the voter cast their ballot for; because the ballot is unique, however, the voter is given a copy of one of the three to take home.  This receipt can later be checked against the ballots that are published so that the voter can verify that their choice was indeed counted.  Again, this publishing doesn't divulge information about whom they voted for, despite the fact that all of the information of the election is published, allowing anyone to perform a recount.

See also:
[Punchscan](http://www.punchscan.org/)
[End-to-end auditable voting systems](http://en.wikipedia.org/wiki/End-to-end_auditable_voting_systems)
