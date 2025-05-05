#include QMK_KEYBOARD_H
#if __has_include("keymap.h")
#    include "keymap.h"
#endif

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LSFT ,KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                               KC_H,   KC_J,     KC_K,    KC_L,    KC_SCLN, SC_SENT,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LCTL, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    MO(1),            LT(2,KC_SPC),KC_N,KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RCTL,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    KC_LALT, KC_LGUI, MO(1),                     LT(2,KC_SPC),KC_TRNS,KC_RALT
                                // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
  ),

  [1] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     KC_TILD, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,                            KC_RBRC, KC_RCBR, KC_RPRN, KC_TRNS, KC_TRNS, KC_DEL,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     QK_BOOT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,                            KC_LBRC, KC_LCBR, KC_LPRN, KC_TRNS, KC_TRNS, KC_TRNS,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LSFT, KC_TRNS, KC_TRNS, KC_TRNS, LALT(KC_E),KC_TRNS,                          KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_TRNS, SC_SENT,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐      ┌──────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LCTL, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,        KC_TRNS,   KC_SCLN, KC_COLN, KC_TRNS, KC_TRNS, KC_TRNS, KC_RCTL,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘      └───┬──────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    KC_TRNS, KC_LGUI, KC_TRNS,                 KC_TRNS,   KC_TRNS, KC_LALT
                                // └────────┴────────┴────────┘               └──────────┴────────┴────────┘
  ),


  [2] = LAYOUT(
  //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
     KC_F12,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                              KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
KC_TRNS, KC_TRNS, KC_KB_VOLUME_UP, KC_COMM, CW_TOGG,  KC_QUOT,                        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, QK_BOOT,
  //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
KC_LSFT, KC_TRNS, KC_KB_VOLUME_DOWN, KC_EQL,  KC_MINS, KC_DQUO,                       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, SC_SENT,
  //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐      ┌──────────┼────────┼────────┼────────┼────────┼────────┼────────┤
     KC_LCTL, KC_TRNS, KC_TRNS, KC_PLUS, KC_UNDS, KC_GRV,  KC_TRNS,          KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, UG_TOGG, KC_RCTL,
  //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘      └───┬──────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                    KC_LALT, KC_LGUI, KC_TRNS,                   KC_TRNS, KC_TRNS, KC_TRNS
                                // └────────┴────────┴────────┘               └──────────┴────────┴────────┘
  ),

};

#ifdef OTHER_KEYMAP_C
#    include OTHER_KEYMAP_C
#endif // OTHER_KEYMAP_C

// clang-format on

// bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
//     switch (keycode) {
// case LSFT_T(KC_A):
// case RSFT_T(KC_SCLN):
// case LGUI_T(KC_F):
// case RGUI_T(KC_J):
// case LALT_T(KC_I): //not used at the moment
// case LCTL_T(KC_O): //not used at the moment
// Do not force the mod-tap key press to be handled as a modifier
// if any other key was pressed while the mod-tap key is held down.
// return false;
// default:
// Force the dual-role key press to be handled as a modifier if any
// other key was pressed while the mod-tap key is held down.
//             return true;
//     }
// }

// Home row mods: Increase tapping term for home row mods
// uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
//     switch (keycode) {
//         // case LSFT_T(KC_A):
//         // case RSFT_T(KC_SCLN):
//         // case LGUI_T(KC_F):
//         // case RGUI_T(KC_J):
//         return TAPPING_TERM + 100;
//         default:
//             return TAPPING_TERM;
//     }
// }
//
// bool get_permissive_hold(uint16_t keycode, keyrecord_t *record) {
//     switch (keycode) {
//         // case LSFT_T(KC_A):
//         // case RSFT_T(KC_SCLN):
//         // case LGUI_T(KC_F):
//         // case RGUI_T(KC_J):
//         // Immediately select the hold action when another key is tapped.
//         return true;
//         default:
//             // Do not select the hold action when another key is tapped.
//             return false;
//     }
// }
//
// // Home row mods: disable quick tap and hold
// uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t *record) {
//     switch (keycode) {
//         // case LSFT_T(KC_A):
//         // case RSFT_T(KC_SCLN):
//         case LGUI_T(KC_F):
//         case RGUI_T(KC_J):
//             // When tapping one of these keys once and then holding,
//             // remove the auto-repeat ability and activate the hold function instead
//             return 0;
//         default:
//             return QUICK_TAP_TERM;
//     }
// }
