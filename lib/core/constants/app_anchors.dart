// Section anchor IDs + their human-readable labels.
//
// Used in three places:
//   1. <section id="..."> in each scroll section.
//   2. <a href="#..."> links in the Navbar and the mobile menu.
//   3. The JS ScrollSpy maps section id -> nav link via these same strings.
//      A section can borrow another link with `data-spy="<id>"` — the Lab
//      section does this so "Work" stays active while you scroll through it.
//
// Keep `items` in scroll order — the navbar renders the list as-is.

abstract final class AppAnchors {
  static const String home       = 'home';
  static const String about      = 'about';
  static const String work       = 'work';
  static const String lab        = 'lab';
  static const String experience = 'experience';
  static const String skills     = 'skills';
  static const String education  = 'education';
  static const String contact    = 'contact';

  /// `#hero` style helper.
  static String hash(String id) => '#$id';

  /// Ordered list rendered by the navbar + mobile menu.
  static const List<({String id, String label})> items = [
    (id: about,      label: 'About'),
    (id: work,       label: 'Work'),
    (id: experience, label: 'Experience'),
    (id: skills,     label: 'Skills'),
    (id: education,  label: 'Education'),
    (id: contact,    label: 'Contact'),
  ];
}
