describe "Register", ->
  describe "validateEmail", ->
    it "Should accept a valid email", ->
      expect(Register.validateEmail("example@email.com")).toBe true

    it "Should not accept a blank email", ->
      expect(Register.validateEmail("")).toBe false

    it "Should not accept inputs without an @", ->
      expect(Register.validateEmail("exampleemail.com")).toBe false

    it "Should not accept inputs without an .", ->
      expect(Register.validateEmail("example@emailcom")).toBe false

  describe "validatePassword", ->
    it "Should accept a valid password", ->
      expect(Register.validatePassword("Password1", "Password1")).toBe true

    it "Should not accept a blank password", ->
      expect(Register.validatePassword("", "Password1")).toBe false
      expect(Register.validatePassword("Password1", "")).toBe false

    it "Should not accept a password without a number", ->
      expect(Register.validatePassword("Password", "Password")).toBe false

    it "Should not accept a password without a lowercase letter", ->
      expect(Register.validatePassword("PASSWORD1", "PASSWORD1")).toBe false

    it "Should not accept a password without a uppercase letter", ->
      expect(Register.validatePassword("password1", "password1")).toBe false

    it "Should not accept a password shorter than six characters", ->
      expect(Register.validatePassword("Pass1", "Pass1")).toBe false

    it "Should not accept a password mismatch", ->
      expect(Register.validatePassword("Password1", "Password2")).toBe false

  describe "validateFirstName", ->
    it "Should accept a valid name", ->
      expect(Register.validateFirstName("Joe")).toBe true

    it "Should not accept a blank name", ->
      expect(Register.validateFirstName("")).toBe false

    it "Should only accept alphanumerical characters", ->
      expect(Register.validateFirstName("Joe@")).toBe false

  describe "validateLastName", ->
    it "Should accept a valid name", ->
      expect(Register.validateLastName("Smith")).toBe true

    it "Should not accept a blank name", ->
      expect(Register.validateLastName("")).toBe false

    it "Should only accept alphanumerical characters", ->
      expect(Register.validateLastName("Smith@")).toBe false