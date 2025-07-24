extension Strings on String {
  ocultEmailLogin() {
    return this.substring(0, 3) + this.substring(indexOf("@"));
  }
}
