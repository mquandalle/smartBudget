describe "Login", ->
  describe "validateEmail", ->
    it "Should not accept a blank email", ->
      expect(Login.validateEmail("")).toBe false

    it "Should accept a valid email", ->
      expect(Login.validateEmail("example@email.com")).toBe true

    it "Should not accept inputs without an @", ->
      expect(Login.validateEmail("exampleemail.com")).toBe false

    it "Should not accept inputs without an .", ->
      expect(Login.validateEmail("example@emailcom")).toBe false