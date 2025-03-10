Param(
    [Parameter(Mandatory=$false)]
    [string]$commitMessage = ""
)

# Si aucun message n'est fourni en argument, on le demande à l'utilisateur.
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = Read-Host "Entrez le message de commit"
}

Write-Host "Ajout des changements..."
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors de l'ajout des fichiers. Abandon." -ForegroundColor Red
    exit 1
}

Write-Host "Création du commit avec le message : '$commitMessage'"
git commit -m "$commitMessage"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du commit (peut-être aucun changement à commit). Abandon." -ForegroundColor Red
    exit 1
}

Write-Host "Poussée vers GitHub sur la branche main..."
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du push vers GitHub. Abandon." -ForegroundColor Red
    exit 1
}

Write-Host "Déploiement sur Netlify en production..."
netlify deploy --prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du déploiement sur Netlify." -ForegroundColor Red
    exit 1
}

Write-Host "Déploiement terminé avec succès !" -ForegroundColor Green
