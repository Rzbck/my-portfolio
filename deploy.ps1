Param(
    [Parameter(Mandatory=$false)]
    [string]$commitMessage = ""
)

# 0. Vérifier si le dossier node_modules existe, sinon installer les dépendances npm
if (!(Test-Path "node_modules")) {
    Write-Host "Dossier 'node_modules' non trouvé. Installation des dépendances via npm install..."
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Erreur lors de l'installation des dépendances npm." -ForegroundColor Red
        exit 1
    }
    Write-Host "Dépendances npm installées avec succès."
}

# 1. Vérification et ajout du remote "origin" si nécessaire
$remoteUrl = git remote get-url origin 2>$null
if ([string]::IsNullOrEmpty($remoteUrl)) {
    $response = Read-Host "Remote 'origin' introuvable. Voulez-vous l'ajouter avec l'URL 'https://github.com/Rzbck/my-portfolio.git'? (Y/N)"
    if ($response -match '^(Y|y)$') {
        git remote add origin https://github.com/Rzbck/my-portfolio.git
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Erreur lors de l'ajout du remote 'origin'." -ForegroundColor Red
            exit 1
        } else {
            Write-Host "Remote 'origin' ajouté avec succès."
        }
    } else {
        Write-Host "Remote 'origin' non configuré. Abandon." -ForegroundColor Red
        exit 1
    }
}

# 2. Vérification de l'installation du Netlify CLI
try {
    $netlifyVersion = netlify --version 2>&1
    if ($netlifyVersion -match "not found") {
        throw "Netlify CLI non trouvé."
    }
} catch {
    Write-Host "Netlify CLI n'est pas installé. Installation via npm install -g netlify-cli..."
    npm install -g netlify-cli
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Erreur lors de l'installation du Netlify CLI." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "Netlify CLI installé avec succès."
    }
}

# 3. Demander un message de commit si non fourni
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = Read-Host "Entrez le message de commit"
}

# 4. Git : Ajout, commit et push
Write-Host "Ajout des changements..."
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors de 'git add'." -ForegroundColor Red
    exit 1
}

Write-Host "Création du commit avec le message : '$commitMessage'"
git commit -m "$commitMessage"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du commit (aucun changement à commit ?)." -ForegroundColor Red
    exit 1
}

Write-Host "Poussée vers GitHub sur la branche courante..."
git push origin HEAD
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du push vers GitHub." -ForegroundColor Red
    exit 1
}

# 5. Exécution de la commande de build (Vite)
Write-Host "Exécution de la commande de build..."
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du build du projet." -ForegroundColor Red
    exit 1
}

# 6. Vérification de l'existence du dossier "dist"
if (!(Test-Path "dist")) {
    Write-Host "Le dossier 'dist' n'a pas été trouvé après le build." -ForegroundColor Red
    exit 1
}

# 7. Déploiement sur Netlify en production (en utilisant le dossier 'dist')
Write-Host "Déploiement sur Netlify en production..."
netlify deploy --prod --dir="dist"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du déploiement sur Netlify." -ForegroundColor Red
    exit 1
}

Write-Host "Mise à jour terminée avec succès !" -ForegroundColor Green
