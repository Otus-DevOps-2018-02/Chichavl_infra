variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable instance_count {
  description = "Number of instance to create"
  default     = 2
}

variable ssh_public_keys {
  description = "Public keys of allowed users"
  default     = "appuser1:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPidPiD0QVEH/SPgcTwdaPVbxniLQznseoDh33tk7dOKF31cl4+nQ7tAo/XEkAPQg82qYT6O4RyMJxzAgBokCv0kp+w9g7kZG/Pb8+fTi8/hSczn0+rN93VG4/LIkth0DLzSkhIBCZge1G/SA52bUbg2BLE61IaItl1OgNhNbv+Pw0JHmkEtDBoRLljajnjJ/L18kxdgZihtDXA0FlN/ttuItNtlBOrPTMQaoteIyiTS9Yy8a4MBESjy3tvFCZqt0+F6DC0vVvCLHOn5dXAF1mQNpYBgutDICUO/gczp/gB5GSllZRxo0zf/bXrBuojDpRp0wOI4nf2uSdfaVT7aaL appuser1\nappuser2:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPidPiD0QVEH/SPgcTwdaPVbxniLQznseoDh33tk7dOKF31cl4+nQ7tAo/XEkAPQg82qYT6O4RyMJxzAgBokCv0kp+w9g7kZG/Pb8+fTi8/hSczn0+rN93VG4/LIkth0DLzSkhIBCZge1G/SA52bUbg2BLE61IaItl1OgNhNbv+Pw0JHmkEtDBoRLljajnjJ/L18kxdgZihtDXA0FlN/ttuItNtlBOrPTMQaoteIyiTS9Yy8a4MBESjy3tvFCZqt0+F6DC0vVvCLHOn5dXAF1mQNpYBgutDICUO/gczp/gB5GSllZRxo0zf/bXrBuojDpRp0wOI4nf2uSdfaVT7aaL appuser2\nappuser3:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPidPiD0QVEH/SPgcTwdaPVbxniLQznseoDh33tk7dOKF31cl4+nQ7tAo/XEkAPQg82qYT6O4RyMJxzAgBokCv0kp+w9g7kZG/Pb8+fTi8/hSczn0+rN93VG4/LIkth0DLzSkhIBCZge1G/SA52bUbg2BLE61IaItl1OgNhNbv+Pw0JHmkEtDBoRLljajnjJ/L18kxdgZihtDXA0FlN/ttuItNtlBOrPTMQaoteIyiTS9Yy8a4MBESjy3tvFCZqt0+F6DC0vVvCLHOn5dXAF1mQNpYBgutDICUO/gczp/gB5GSllZRxo0zf/bXrBuojDpRp0wOI4nf2uSdfaVT7aaL appuser3"
}
