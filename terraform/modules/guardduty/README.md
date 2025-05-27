# ✅ Module GuardDuty

Active AWS GuardDuty pour la détection des menaces sur le compte.

## 📥 Inputs

Aucune variable requise.

## 📤 Outputs

| Output               | Description                           |
|----------------------|---------------------------------------|
| detector_id          | ID du détecteur GuardDuty             |
| guardduty_enabled    | Booléen indiquant si c’est activé     |

## ✅ Exemple d’appel

```hcl
module "guardduty" {
  source = "./guardduty"
}
