Require Export Basics.

Theorem plus_n_O : forall (n : nat), n + 0 = n.
Proof.
  intros n. induction n as [ | n' IHn'].
  + auto.
  + simpl. rewrite IHn'. reflexivity.
Qed.

Theorem minus_diag : forall n : nat, minus n n = 0.
Proof.
  intros n. induction n.
  + auto.
  + simpl. rewrite IHn. reflexivity.
Qed.

Theorem mult_r_0 : forall n : nat,
    n * 0 = 0.
Proof.
  intros n. induction n.
  + reflexivity.
  + simpl. rewrite IHn. reflexivity.
Qed.

Theorem plus_n_Sm : forall (n m : nat),
    S (n + m) = n +  S m.
Proof.
  intros n. induction n.
  + reflexivity.
  + simpl. intros m. rewrite IHn. reflexivity.
Qed.

Theorem plus_comm : forall (n m : nat),
    n + m = m + n.
Proof.
  intros n. induction n.
  + simpl. intros m. rewrite plus_n_O. reflexivity.
  + simpl. intros m. rewrite <- plus_n_Sm. rewrite IHn.
    reflexivity.
Qed.

Theorem plus_assoc : forall (n m p : nat),
    n + (m + p) = (n + m) + p.
Proof.
  intros n.  induction n.
  {
    intros m p. simpl. reflexivity.
  }
  {
    intros m p. simpl. rewrite IHn. reflexivity.
  }
Qed.

Fixpoint double (n : nat) : nat :=
  match n with
  | O => O
  | S n' => S (S (double n'))
  end.

Theorem double_plus : forall (n : nat),
    double n = n + n.
Proof.
  intros n. induction n.
  + reflexivity.
  + simpl. rewrite <- plus_n_Sm. rewrite IHn.
    reflexivity.
Qed.

Theorem evenb_S : forall (n : nat),
    evenb (S n) = negb (evenb n).
Proof.
  intros n. induction n.
  + simpl. reflexivity.
  + rewrite IHn. simpl. rewrite negb_involutive. reflexivity.
Qed.

Theorem mult_0_plus :
  forall (n m : nat), (0 + n) * m = n * m.
Proof.
  intros n m.
  assert (H : 0 + n = n).
  {
    Require Export Omega. omega.
  }
  rewrite H. reflexivity.
Qed.


Theorem plus_rearrange : forall (n m p q : nat),
    (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (H : n + m = m + n).
  {
    rewrite plus_comm. reflexivity.
  }
  rewrite H. reflexivity.
Qed.

(* it can be solved easily by omega tactic *)

Theorem plus_swap : forall (n m p : nat),
    n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite plus_assoc. rewrite plus_assoc.
  assert (H : n + m = m + n).
  {
    rewrite plus_comm. reflexivity.
  }
  rewrite H. reflexivity.
Qed.


(*
Theorem mult_comm : forall (n m : nat),
    m * n = n * m.
Proof.
  intros n. induction n.
  { intros m. rewrite mult_r_0. reflexivity.}
  {
    intros m. simpl. rewrite <- IHn.
    assert (H : m + m * n = m * S n).
    {
      induction m.
      + reflexivity.
      + simpl.  rewrite <- IHm. rewrite plus_assoc.
        rewrite plus_swap. rewrite plus_assoc.
        reflexivity.
    }
    rewrite H. reflexivity.
  }
    Qed.

proof is correct but may be something wrong with 
proof-general or company-coq *)

Theorem leb_refl : forall n : nat,
    leb n n = Datatypes.true.
Proof.
  intros n. induction n.
  + reflexivity.
  + simpl. assumption.
Qed.


Theorem zero_nbeq_S : forall n : nat,
    beq_nat 0 (S n) = Datatypes.false.
Proof.
  intros n. reflexivity.
Qed.

Theorem beq_nat_refl : forall n : nat,
    Datatypes.true = beq_nat n n.
Proof.
  intros n. induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Theorem plus_swap' : forall (n m p : nat),
    n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite plus_assoc. replace (n + m) with (m + n).
  rewrite plus_assoc. reflexivity. rewrite plus_comm.
  reflexivity.
Qed.

Fixpoint nat_to_bin (n : nat) : bin :=
  match n with
  | O =>Zero
  | S n' => incr (nat_to_bin n')
  end.

Compute (nat_to_bin 100).

Theorem nat_bin_identity :
  forall n : nat, bin_to_nat (nat_to_bin n) = n.
Proof.
  intros n. induction n.
  + reflexivity.
  + simpl.
    assert (H : forall b : bin, bin_to_nat (incr b) = S (bin_to_nat b)).
    {
      intros b. induction b.
      + simpl. reflexivity.
      + simpl. reflexivity.
      + simpl. rewrite IHb. simpl. rewrite <- plus_n_Sm.
        reflexivity.
    }
    rewrite H. rewrite IHn. reflexivity.
Qed.


Theorem mult_comm' : forall (n m : nat),
    m * n = n * m.
Proof.
  intros n. induction n.
  - intros m. rewrite mult_r_0. reflexivity.
  - intros m. simpl. rewrite <- IHn.
    assert (H : m + m * n = m * S n).
    {
      induction m.
      + reflexivity.
      + simpl.  rewrite <- IHm. rewrite plus_assoc.
        rewrite plus_swap. rewrite plus_assoc.
        reflexivity.
    }
    rewrite H. reflexivity.
Qed.

