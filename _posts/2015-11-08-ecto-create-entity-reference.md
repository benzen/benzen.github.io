---
layout: post
title: Create entity with reference 
tags: elixir ecto phoenix reference
---

Looking for advice on how to insert entity that reference other entity with Ecto ?
This may help you.

What ?
-----

A very consice description of how to insert an new entity with reference to an already inserted entity.

Why ?
-------

When I was trying to do this with ecto, I did't find reference on this. I've found solution to much more
advanced questions, but simple one also need guidance for beginners.

How ?
-----

So here is my problem.
I have an entity `User`, I've created it with phoenix tool chain, like this:

```bash
$ mix 
mix phoenix.gen.model User users email:string password:string
```

Quite easy, I've made a couple of changes to this model as described (here)[http://meatherly.github.io/2015/05/11/phoenixauthentication/], 
in order to add an encrypted password.

Then I've added another entity `Couple`. The couple is an entity that group two user together, like  a couple.

```bash
mix phoenix.gen.model Couple couples partner_1:references:users partner_2:references:users
```

Here is how you could create the couple in db from your app

```elixir

  def couple(conn, %{:other_user_id => other_user_id ) do 
    current_user_id = get_session(conn, :current_user)
    changeset = %Couple{}
    |> Couple.changeset(%{})
    |> Changeset.put_change(:partner1_id, current_user_id)
    |> Changeset.put_change(:partner2_id, other_user_id)

    #Then do stuff like
    changeset.valid?
    #or
    Repo.insert changeset
  end
```

At first this seams strange, when you never worked with Ecto.
Once you've got the idea, you'll understand that hibernate session is really a terrible idea.

In Ecto you create a changeset for an entity. You will accumulate manipulation on
your changeset, like with your git/mercurial.
Once your happy with the changeset you'll insert it into the db, like a commit.

I didn't explain why nor how to validate and insert. For thoses information the
official Ecto documentation is well done.

I hope this very tiny guide will help some of use to progress a little bit further will Elixir and Phoenix.
