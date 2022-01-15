class Strings {
  //const string values
  static const String app_name                = 'Project management';
  static const String demo_user_name          = 'Tony stark';
  static const String demo_user_email         = 'example@mail.com';
  static const String demo_user_logo_url      = 'https://picsum.photos/250?image=9';
  static const String date_format             = 'dd/MM/yyyy';
  //const labels
  //operations
  static const String operation_create_title  = 'Create';
  static const String operation_cancel_title  = 'Cancel';
  static const String operation_delete_title  = 'Delete';
  static const String operation_update_title  = 'Update';
  static const String current_user            = 'Current user';
  //group page
  static const String create_new_group        = 'Create new group';
  static const String edit_group              = 'Edit group';
  static const String new_group               = 'New group';
  //project page
  static const String create_new_project      = 'Create new project';
  static const String edit_project            = 'Edit project';
  static const String new_project             = 'New project';
  static const String running_projects        = 'Live projects';
  static const String completed_projects      = 'Completed projects';
  static const String cancelled_projects      = 'Cancelled projects';
  //contents page
  //tabs
  static const String tab_goals               = 'Goals';
  static const String tab_notes               = 'Notes';
  //goals
  static const String create_new_goal         = 'Create new goal';
  static const String edit_goal               = 'Edit goal';
  static const String new_goal                = 'New goal';
  static const String running_goals           = 'Live goals';
  static const String completed_goals         = 'Completed goals';
  static const String cancelled_goals         = 'Cancelled goals';
  //notes
  static const String create_new_note         = 'Create new note';
  static const String edit_note               = 'Edit note';
  static const String new_note                = 'New note';
  //sign in page
  static const String sign_in                 = 'Sign in';
  static const String sign_in_with_google     = 'Sign in with Google';
  static const String signing_in              = 'Signing in, wait a sec.';
  static const String sign_in_failed          = 'Sign in failed';
  //form textField labels
  static const String label_name              = 'Name';
  static const String label_created_on        = 'Created on';
  static const String label_current_status    = 'Current status';
  static const String label_content           = 'Content';
  //fireStore transaction
  static const String no_operation_found      = 'No operation found.';
  static const String label_success           = 'success';

  //
  static const String creating_group          = 'Group will be created soon.';
  static const String deleting_group          = 'Group will be deleted soon.';
  //
  static const String creating_project        = 'Project will be created soon';
  static const String deleting_project        = 'Project will be deleted soon';
  //
  static const String creating_goal           = 'Goal will be created soon';
  static const String deleting_goal           = 'Goal will be deleted soon';
  //
  static const String creating_note            = 'Note will be created soon';
  static const String deleting_note           = 'Note will be deleted soon';

  //account dialog
  static const String sign_out                = 'Sign out';
  //
  static const String back                    = 'Back';
  static const String no_results_found        = 'No results found.';
  static const String loading                 = 'Loading data, wait a sec';
  static const String updating                = 'Changes will be applied soon.';

}

class Fonts {
  static const String firacode = 'FiraCode';
  static const String raleway  = 'Raleway';
  static const String roboto = 'Roboto';
}

class ImagesFromAssets {
  static const String android = 'assets/images/android.jpg';
  static const String google  = 'assets/images/google_logo.png';
  static const String facebook= 'assets/images/facebook_logo.png';
  static const String fuchsia = 'assets/images/fuchsia.png';
}

class FireStoreCollection {
  static const String groups    = 'project_groups';
  static const String projects  = 'projects';
  static const String goals     = 'goals';
  static const String notes     = 'notes';
}