reset_dirs_cm-11.0() {
  RESET_DIRS=(
    'packages/providers/ContactsProvider/'
  )

  # Directories that should be reset for one more build
  RESET_DIRS_OLD=(
  )

  for i in ${RESET_DIRS[@]} ${RESET_DIRS_OLD[@]}; do
    if [ -d "${i}" ]; then
      if [ -d "${i}/.git/refs/remotes/github" ]; then
        reset_git_state ${i} cxl/${REPO_BRANCH}
      else
        reset_git_state ${i} github/${REPO_BRANCH}
      fi
    fi
  done
}

apply_patches_cm-11.0() {
  PATCHES=${WORKSPACE}/hudson/roms/${REPO_BRANCH}
  FACEBOOKSYNC=${PATCHES}/facebook-sync

  pushd packages/providers/ContactsProvider/
  apply_patch_file_git ${FACEBOOKSYNC}/0001-ContactsProvider-Hack-to-enable-Facebook-contacts-sy.patch
  popd

  python3 ${WORKSPACE}/hudson/gerrit_changes.py \
    `# frameworks/base` \
    'http://review.cyanogenmod.org/#/c/53468/' `# Reimplement expanded desktop on top of immersive mode.`                                 \
    'http://review.cyanogenmod.org/#/c/53502/' `# SystemUI: fix RecentPanel position in landscape mode.`                                  \
    'http://review.cyanogenmod.org/#/c/53827/' `# framework/base: Add EdgeGesture service.`                                               \
    'http://review.cyanogenmod.org/#/c/53892/' `# SystemUI: fix recents animation in expanded mode.`                                      \
    'http://review.cyanogenmod.org/#/c/54137/' `# base: Forward Port Circle Battery (WIP)`                                                \
    'http://review.cyanogenmod.org/#/c/54398/' `# NavigationBar : Customization`                                                          \
    'http://review.cyanogenmod.org/#/c/54787/' `# Keyguard: fix statusbar lags when default widget shown.`                                \

    `# packages/apps/Settings` \
    'http://review.cyanogenmod.org/#/c/54139/' `# Forward Port Circle Battery (WIP)`                                                      \
    'http://review.cyanogenmod.org/#/c/54219/' `# Add back hardware key settings.`                                                        \
    'http://review.cyanogenmod.org/#/c/54326/' `# Add back navigation ring customization.`                                                \
    'http://review.cyanogenmod.org/#/c/54399/' `# Add back navigation bar customization.`                                                 \

#    `# Camera stuff` \
#    I26898b82f6c9ab81e6f1681805de229e4ac2f308 \
#    I56739157380f596c9f3bbbe7aecd8f532d619c72 \
#    Ia0f5716d5e6815d249040b08313482a103a36863 \
#    I216502fe032a89f69e1aea11bc50c51634d40991 \
#    Ib36bd21c9a76b45bced3eee2f25acc35b5d82b30

}
