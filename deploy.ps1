Param(
    [Parameter(Mandatory=$false)]
    [string]$commitMessage = ""
)

# Si aucun message n'est fourni, demandez-le à l'utilisateur
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = Read-Host "Entrez le message de commit"
}

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

Write-Host "Déploiement sur Netlify en production..."
netlify deploy --prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du déploiement sur Netlify." -ForegroundColor Red
    exit 1
}

Write-Host "Mise à jour terminée avec succès !" -ForegroundColor Green
