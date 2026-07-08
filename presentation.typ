#import "@preview/touying:0.7.4": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  align: horizon,
  config-info(
    title: [Coalition Logic and Quantification],
    subtitle: [From Modal Logic to Quantified Coalition Logic],
    author: [Luca Sforza],
    date: datetime.today(),
    institution: [Logic Course],
    logo: emoji.sparkles,
  ),
)

#pdfpc.config(
  duration-minutes: 30,
  last-minutes: 2,
  note-font-size: 12,
)

#set heading(numbering: "{1}.")

// ============================================================
// SLIDE 1 — Title
// ============================================================
#title-slide()

#speaker-note[
  + Welcome everyone. State your name and the topic.
  + This presentation covers coalition logic and its quantified extension.
  + The talk is structured in 8 parts, lasting about 30 minutes.
  + You will use game-theoretic frameworks to reason about multi-agent systems.
  + Timing: 0:00 to 0:30.
]

// ============================================================
// SLIDE 2 — Outline
// ============================================================
== Outline

- Introduction: From Kripke Models to Game Frames
- The Concept of Coalitional Power
- Coalition Logic (CL): Syntax and Semantics
- Axiomatization and Limits of CL
- Quantified Coalition Logic (QCL)
- Quantified Operators
- Metatheory: Computational Complexity
- Applications: Voting and Social Choice
- Conclusions and Reflections

#speaker-note[
  + Briefly walk through the 8 sections.
  + Emphasize the logical progression: single-agent modal logic, multi-agent, coalition logic, quantified coalition logic.
  + Mention that Section 7 (complexity) and Section 8 (voting applications) tie everything together.
  + Timing: 0:30 to 1:00.
]

// ============================================================
// SLIDE 3 — Introduction: From Kripke to Game Frames
// ============================================================
= Introduction: From Kripke Models to Game Frames

== Single-Agent Modal Logic

- In the simplest case, we have *one agent* who can choose between actions.
- A *Kripke model* uses an accessibility relation $R$ that associates to every state all reachable states.
- A modal formula $diamond phi$ means: "the agent can act so that $phi$ will be true."

#speaker-note[
  + Start with the familiar: Kripke models for single-agent modal logic.
  + An agent at state $s$ can move to state $t$ if $s R t$.
  + The modality $diamond phi$ expresses possibility: there exists an accessible state where $phi$ holds.
  + This is the foundation that we will generalize.
  + Timing: 1:00 to 2:00.
]

// ============================================================
// SLIDE 4 — The Multi-Agent Problem
// ============================================================
== The Multi-Agent Problem

- Extending to multiple agents with individual accessibility relations $R_i$ considers agents *in isolation*.
- But agents' actions *interact*: what happens when agent 1 and agent 2 act *simultaneously*?
- The outcome depends on the *combination* of all participants' choices.

#pause

== The Solution: Game Frames

- Marc Pauly introduces *game frames* (2002).
- Each state is associated with a *strategic game* among the agents.
- Outcomes of the game are states of the model, leading to *Coalition Logic* (CL).

#speaker-note[
  + This is the key motivation: standard multi-agent logics treat agents independently.
  + But in reality, actions interact. If agent 1 moves left and agent 2 moves right, the result is a joint outcome.
  + Game frames solve this by associating each state with a strategic game.
  + The outcome function maps strategy profiles to states.
  + This is the foundation of Coalition Logic.
  + Timing: 2:00 to 4:00.
]

// ============================================================
// SLIDE 5 — The Concept of Coalitional Power
// ============================================================
= The Concept of Coalitional Power

== Strategic Games

A strategic game $G = (N, {Sigma_i | i in N}, o, S)$ consists of:

- $N$: finite set of agents (players)
- $Sigma_i$: set of strategies for agent $i$
- $S$: set of outcome states
- $o: product_(i in N) Sigma_i -> S$: outcome function

#speaker-note[
  + Define the formal building block: a strategic game.
  + $N$ is the set of players, $Sigma_i$ the strategies, $S$ the states.
  + The outcome function $o$ takes a strategy profile (one strategy per player) and returns a state.
  + This is a game form with no preferences yet, just the mechanics.
  + Timing: 4:00 to 5:00.
]

// ============================================================
// SLIDE 6 — Game Frames
// ============================================================
== Game Frames

#block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + blue), fill: blue.lighten(95%))[
  *Definition.* #h(0.5em)
  Let $Gamma^N_S$ be the set of all strategic games over agents $N$ and states $S$.
  A _game frame_ is a pair $(S, gamma)$ where $gamma: S -> Gamma^N_S$ assigns a strategic game to each state.
]

- Game frames are essentially *extensive games with simultaneous moves*.
- At every state, agents play a game; the outcome leads to a new state (and a new game).

#speaker-note[
  + A game frame is a transition system where transitions are strategic games.
  + At each state $s$, the function $gamma$ gives the game that agents must play.
  + The outcome of that game determines the next state.
  + This is more general than Kripke frames: instead of a simple relation, we have a full game.
  + Timing: 5:00 to 6:00.
]

// ============================================================
// SLIDE 7 — Effectivity Functions
// ============================================================
== From Strategy to Power: Effectivity Functions

#block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + blue), fill: blue.lighten(95%))[
  *Definition.* #h(0.5em)
  The _effectivity function_ $E_G: cal(P)(N) -> cal(P)(cal(P)(S))$ derived from game $G$ is defined as:
  $X in E_G(C) <=> exists sigma_C forall sigma_(N without C): o(sigma_C, sigma_(N without C)) in X$
]

- Coalition $C$ is *effective* for $X$ if $C$ has a joint strategy that *forces* the outcome into $X$, regardless of what the others do.

#speaker-note[
  + This is the central concept: effectivity functions.
  + $X in E_G(C)$ means coalition $C$ can force the outcome into set $X$.
  + The quantifier structure is key: EXISTS a strategy for $C$, FOR ALL strategies of the opponents.
  + This captures the idea of "forcing": the coalition has a winning strategy.
  + The logic will reason about these effectivity functions directly.
  + Timing: 6:00 to 8:00.
]

// ============================================================
// SLIDE 8 — Playability Properties
// ============================================================
== Playability Properties

Not every function can represent a real game. An effectivity function must be *playable*:

/ Outcome-monotonicity: If $C$ can force $X$, it can force any $Y supset.eq X$.
/ Superadditivity: If disjoint $C_1, C_2$ force $X_1, X_2$ respectively, then $C_1 union C_2$ can force $X_1 inter X_2$.
/ $N$-maximality: The grand coalition can force $X$ iff the empty coalition cannot force $S without X$.

#speaker-note[
  + These three properties ensure the effectivity function comes from a real game.
  + Outcome-monotonicity: if you can guarantee winning, you can guarantee "someone wins."
  + Superadditivity: disjoint coalitions can combine their strategies, cooperation pays off.
  + $N$-maximality: if nobody can prevent $X$, then everyone together can achieve it.
  + These properties will be reflected as axioms in the logic.
  + Timing: 8:00 to 9:00.
]

// ============================================================
// SLIDE 9 — Coalition Logic: Syntax
// ============================================================
= Coalition Logic (CL): Syntax and Semantics

== Syntax: The Coalition Operator

Given agents $cal(A)g$ and atomic propositions $Phi$:

$ phi ::= p | not phi | phi_1 or phi_2 | angle.l angle.r C angle.r angle.r phi $

- $angle.l angle.r C angle.r angle.r phi$ means: "coalition $C$ has a joint strategy to *force* an outcome satisfying $phi$, regardless of the actions of $cal(A)g without C$."

#speaker-note[
  + Introduce the modal operator of Coalition Logic.
  + The double angle brackets denote the coalition ability operator.
  + It is read as "C can achieve phi."
  + We use this notation to avoid confusion with the universal quantifier $[P]phi$ in QCL.
  + Timing: 9:00 to 10:00.
]

// ============================================================
// SLIDE 10 — Coalition Frames and Models
// ============================================================
== From Coalition Frames to Models

/ Coalition Frame: A pair $cal(F) = (S, E)$ where $E$ assigns a playable effectivity function to each state.
/ Coalition Model: A triple $cal(M) = (S, E, pi)$ adding a valuation $pi$.

#pause

The semantics:

$ cal(M), s models angle.l angle.r C angle.r angle.r phi <=> phi^cal(M) in E(s, C) $

where $phi^cal(M) = {t in S | cal(M), t models phi}$.

#speaker-note[
  + Frames give structure; models add truth values for propositions.
  + The semantics is elegant: $C$ can force $phi$ iff the set of $phi$-states is in the effectivity of $C$ at $s$.
  + This directly connects the logic to the game-theoretic notion of effectivity.
  + The formula $phi^cal(M)$ is the set of states where $phi$ is true.
  + Timing: 10:00 to 11:00.
]

// ============================================================
// SLIDE 11 — The Characterization Theorem
// ============================================================
== The Characterization Theorem (Theorem 3.2)

#block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + purple), fill: purple.lighten(95%))[
  *Theorem (Characterization).* #h(0.5em)
  An effectivity function $E$ is playable if and only if there exists a strategic game $G$ such that the effectivity function induced by $G$ coincides with $E$.
]

#speaker-note[
  + This is the most important theoretical result in CL.
  + It bridges two worlds: the abstract algebraic world of effectivity functions, and the concrete world of strategic games.
  + The forward direction is straightforward: every game induces a playable effectivity function.
  + The reverse direction is the deep one: every playable function comes from some game.
  + This justifies working directly with effectivity functions in the logic.
  + Timing: 11:00 to 12:00.
]

// ============================================================
// SLIDE 12 — Proof Sketch
// ============================================================
== Proof Sketch

$(=>)$: If $E$ is induced by a game $G$:
- Outcome-monotonicity: same strategy works for supersets.
- Superadditivity: disjoint strategies do not interfere.
- $N$-maximality: the grand coalition controls everything.

#pause

$(<=)$: If $E$ is playable, construct an artificial game:
- Introduce strategies representing guaranteed choices from $E$.
- Define outcomes so that a winning strategy produces exactly the declared set.
- Playability properties ensure consistency.

#speaker-note[
  + The forward direction is almost immediate from the definitions.
  + For superadditivity: if $C_1$ and $C_2$ are disjoint, their strategies do not conflict, so they can be played simultaneously.
  + For the reverse direction: the construction is non-trivial. You build a game where each coalition's "power" matches what $E$ declares.
  + The three playability properties are essential for the construction to be consistent.
  + Timing: 12:00 to 14:00.
]

// ============================================================
// SLIDE 13 — Axiomatization
// ============================================================
= Axiomatization and Limits of CL

== Axiom System

The axiomatization by Pauly (complete for weak playability models):

/ Consistency ($bot$): $not angle.l angle.r C angle.r angle.r bot$ --- no coalition can force the impossible.
/ Efficacy ($top$): $angle.l angle.r C angle.r angle.r top$ --- every coalition can always force something trivially true.
/ $cal(A)g$-maximality: $not angle.l angle.r emptyset angle.r angle.r not phi -> angle.l angle.r cal(A)g angle.r angle.r phi$.
/ Superadditivity ($S$): $(angle.l angle.r C_1 angle.r angle.r phi_1 and angle.l angle.r C_2 angle.r angle.r phi_2) -> angle.l angle.r C_1 union C_2 angle.r angle.r (phi_1 and phi_2)$ for $C_1 inter C_2 = emptyset$.

#speaker-note[
  + These axioms mirror the playability properties.
  + Consistency: nothing can force a contradiction.
  + Efficacy: every coalition can always do something.
  + $cal(A)g$-maximality: what the empty coalition cannot make inevitable, the grand coalition can achieve.
  + Superadditivity is the most critical: it captures the ability to combine strategies.
  + This axiom is what makes satisfiability PSPACE-complete rather than NP-complete.
  + Timing: 14:00 to 15:00.
]

// ============================================================
// SLIDE 14 — The Succinctness Problem
// ============================================================
== The Succinctness Problem

To express "some coalition can force $phi$" in CL:

$ angle.l angle.r C_1 angle.r angle.r phi or angle.l angle.r C_2 angle.r angle.r phi or dots or angle.l angle.r C_(2^n) angle.r angle.r phi $

- With $n$ agents, this formula grows *exponentially* ($2^n$ disjuncts).
- Expressing general properties like "a majority can win" is *practically impossible* in CL.

#speaker-note[
  + This is the key limitation that motivates QCL.
  + In CL, you must enumerate every possible coalition explicitly.
  + For $n$ agents, there are $2^n$ coalitions, exponential blowup.
  + A simple property like "some majority can force $phi$" requires listing all majority coalitions.
  + For $n = 100$ voters, this is astronomically large.
  + Timing: 15:00 to 17:00.
]

// ============================================================
// SLIDE 15 — QCL: Coalition Predicates
// ============================================================
= Quantified Coalition Logic (QCL): Coalition Predicates

== The Innovation: Predicates over Coalitions

Instead of enumerating members, describe coalitions via *predicates* $P$:

- *Inclusion:* Coalition $C$ is a subset of $D$.
- *Containment:* Coalition $C$ contains $D$.
- Combined with Boolean connectives.

#pause

== The Cardinality Predicate

- A predicate that identifies coalitions of size at least $n$.
- Written as $abs(C) >= n$.

#speaker-note[
  + QCL's innovation is not more expressive power, but more concise representation.
  + Predicates describe properties of coalitions: is this coalition a subset of $D$? Does it contain $D$?
  + The cardinality predicate is crucial: it identifies all coalitions of size at least $n$.
  + Majority becomes a single predicate instead of an exponential disjunction.
  + Timing: 17:00 to 19:00.
]

// ============================================================
// SLIDE 16 — QCL: Quantified Operators
// ============================================================
== Quantified Operators: $angle.l P angle.r$ and $[P]$

#slide(
  repeat: 2,
  self => [
    #let (uncover,) = utils.methods(self)

    #uncover("1-")[
      *Existential:* $angle.l P angle.r phi$ --- there exists a coalition $C$ satisfying $P$ that can force $phi$.
    ]

    #uncover("2-")[
      *Universal:* $[P] phi$ --- all coalitions satisfying $P$ can force $phi$.
    ]

    #pause

    #uncover("2-")[
      Semantics:
      $ cal(M), s models [P] phi <=> forall C subset.eq cal(A)g: (C models P => phi^cal(M) in E(C, s)) $
    ]
  ]
)

#speaker-note[
  + The existential $angle.l P angle.r phi$: SOME coalition with property $P$ can force $phi$.
  + The universal $[P] phi$: ALL coalitions with property $P$ can force $phi$.
  + Important: $[P]$ is NOT simply the dual of $angle.l P angle.r$. The dual would be $forall exists$, but $[P]$ follows $forall exists forall$, the correct quantifier pattern for collective ability.
  + This subtlety is essential for modeling coalition power correctly.
  + Timing: 19:00 to 21:00.
]

// ============================================================
// SLIDE 17 — Exponential Succinctness
// ============================================================
== Exponential Succinctness of QCL

#block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + purple), fill: purple.lighten(95%))[
  *Theorem (Succinctness).* #h(0.5em)
  There exists an infinite family of QCL formulas such that any equivalent CL formula has exponential length.
]

#pause

Example: "some majority can force $phi$"

- *In QCL:* $angle.l "majority" angle.r phi$ --- one formula, constant size.
- *In CL:* exponential disjunction of all majority coalitions.

#speaker-note[
  + This is the main theoretical result of the paper by Agotnes, van der Hoek, and Wooldridge.
  + QCL and CL have the same expressive power: nothing new is expressible.
  + But QCL is exponentially more succinct: the same property can be stated with much shorter formulas.
  + The proof compares the length of formulas in both logics for the majority property.
  + In CL, you must list all majority coalitions. In QCL, just one predicate.
  + Timing: 21:00 to 23:00.
]

// ============================================================
// SLIDE 18 — Complexity
// ============================================================
= Metatheory: Computational Complexity

== CL is PSPACE-complete

- Satisfiability for CL is *PSPACE-complete* (Pauly 2002).
- This is harder than propositional logic (NP-complete) because of the *superadditivity axiom*.
- The computer must reason about how strategies *combine* when coalitions form.

#pause

== QCL: No Additional Cost

- *Satisfiability:* PSPACE-complete, same as CL.
- *Model checking:* polynomial time (explicit models), PSPACE-complete (concise representations like RML).

#speaker-note[
  + The superadditivity axiom is what makes CL harder than propositional logic.
  + You cannot just check each coalition independently; you must consider how they combine.
  + The surprise: despite being exponentially more succinct, QCL has the SAME complexity as CL.
  + This means QCL is strictly better for humans (shorter formulas) without being worse for machines.
  + This is a rare and desirable property in logic.
  + Timing: 23:00 to 26:00.
]

// ============================================================
// SLIDE 19 — Application: Majority Voting
// ============================================================
= Applications: Voting and Social Choice Mechanisms

== Majority Voting: CL vs QCL

Consider $n$ agents choosing between outcomes $omega_1$ and $omega_2$.

#pause

*In QCL, compact specification:*
- Majority power: $["majority"] omega_1 and ["majority"] omega_2$
- Minority restriction: $(not angle.l "non-majority" angle.r omega_1) and (not angle.l "non-majority" angle.r omega_2)$
- Guaranteed outcome: $angle.l "any" angle.r (omega_1 or omega_2)$
- Incompatibility: $angle.l "any" angle.r not (omega_1 and omega_2)$

#speaker-note[
  + This is the crown jewel application: voting systems.
  + In QCL, you can specify a complete majority voting system in 4 short formulas.
  + The predicates capture the essence: "any group of size > n/2 can determine the outcome."
  + Compare this to CL, where each formula would need to list all majority coalitions explicitly.
  + For $n = 100$, the CL version would be astronomically long.
  + Timing: 26:00 to 28:00.
]

// ============================================================
// SLIDE 20 — CL vs QCL Comparison
// ============================================================
== Why This Matters

#table(
  columns: (1fr, 1fr, 1fr),
  align: (center, center, center),
  table.header([*Property*], [*CL*], [*QCL*]),
  [Expressive power], [Full], [Same as CL],
  [Formula length], [Exponential], [Polynomial],
  [Satisfiability], [PSPACE-complete], [PSPACE-complete],
  [Model checking], [P / PSPACE], [P / PSPACE],
)

#speaker-note[
  + Summary table comparing CL and QCL.
  + Same expressive power, same complexity, but QCL is exponentially more succinct.
  + This makes QCL the practical choice for specifying multi-agent systems.
  + The theoretical foundation (effectivity functions, game frames) remains the same.
  + Timing: 28:00 to 29:00.
]

// ============================================================
// SLIDE 21 — Conclusions
// ============================================================
= Conclusions and Reflections

== The Unifying Vision

- Coalition Logic provides a *unifying game-theoretic view* of modal logic.
- Normal and non-normal modal logics emerge as 1- and 2-player versions of CL.
- Every formula is anchored to a concrete game frame.

#pause

== From Theory to Practice

- QCL makes complex social mechanisms (voting, cooperation) *specifiable and verifiable*.
- Marc Pauly's "Social Software": formally verifying the robustness of institutions.
- Future work: integrating preferences and knowledge for deeper understanding of coalition formation.

#speaker-note[
  + Conclude by emphasizing the unifying power of CL.
  + Traditional modal logic is just the 1-player case of Coalition Logic.
  + QCL bridges theory and practice: you can now specify and verify real systems.
  + "Social Software" is Pauly's vision: using logic to design and verify social institutions.
  + Thank the audience. Open for questions (10 minutes).
  + Timing: 29:00 to 30:00.
]

// ============================================================
// SLIDE 22 — Questions
// ============================================================
#focus-slide[
  _Questions?_
]

#speaker-note[
  + Thank the audience for their attention.
  + Remind them of the 10-minute Q&A session.
  + Be prepared to explain:
    - Why superadditivity makes CL PSPACE-complete.
    - The difference between $[P]phi$ and $not angle.l P angle.r not phi$.
    - How to read speaker notes with pdfpc.
]

// ============================================================
// Export pdfpc metadata
// ============================================================
// Run: typst query --root . ./presentation.typ --field value --one "<pdfpc-file>" > ./presentation.pdfpc
