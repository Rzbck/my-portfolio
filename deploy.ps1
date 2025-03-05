Param(
    [Parameter(Mandatory=$false)]
    [string]$commitMessage = ""
)

# 1. Vérification du remote "origin"
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
} catch {
    Write-Host "Netlify CLI n'est pas installé. Veuillez l'installer avec : npm install -g netlify-cli" -ForegroundColor Red
    exit 1
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

# 5. Déploiement sur Netlify en production
Write-Host "Déploiement sur Netlify en production..."
netlify deploy --prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du déploiement sur Netlify." -ForegroundColor Red
    exit 1
}

Write-Host "Mise à jour terminée avec succès !" -ForegroundColor Green
